import argparse
import multiprocessing
import threading
import time
import os
from functools import wraps
from urllib.request import urlopen

import numpy
import sys
import yaml
from scipy.stats import truncnorm

max_per_second = 0
url = None
normal_distribution = None
max_execution_time = 1

def get_truncated_normal(mean=0.0, sd=1, low=0, upp=10):
    return truncnorm(
        (low - mean) / sd, (upp - mean) / sd, loc=mean, scale=sd)


def rate_limited():
    """
    Decorator that make functions not be called faster than

    set mode to 'kill' to just ignore requests that are faster than the
    rate.

    set delay_first_call to True to delay the first call as well
    """
    lock = threading.Lock()

    def decorate(func):
        last_time_called = [0.0]

        @wraps(func)
        def rate_limited_function(*vargs, **kwargs):
            def run_func():
                nonlocal last_time_called
                ret = func(*vargs, **kwargs)
                last_time_called[0] = time.perf_counter()
                lock.release()
                return ret

            lock.acquire()
            nonlocal last_time_called
            global max_per_second
            min_interval = 1.0 / float(max_per_second)
            elapsed = time.perf_counter() - last_time_called[0]
            left_to_wait = min_interval - elapsed
            # Allows the first call to not have to wait
            if not last_time_called[0] or elapsed > min_interval:
                return run_func()
            elif left_to_wait > 0:  # Kill
                lock.release()
                return

        return rate_limited_function

    return decorate


def get_rand_cps_int(slots=1):
    x1 = get_truncated_normal(mean=normal_distribution["mean"], sd=normal_distribution["standard_deviation"],
                              low=normal_distribution["lower_limit"], upp=normal_distribution["upper_limit"])
    return numpy.round(x1.rvs(slots))


@rate_limited()
def do_request():
    global url
    urlopen(url, timeout=1)
    return


class HttpWorker(threading.Thread):
    _end = False

    def stop(self):
        self._end = True

    def run(self):
        while not self._end:
            do_request()


def main():
    global max_per_second, max_execution_time
    max_per_second = get_rand_cps_int()[0]
    print("Limited ", max_per_second)
    thread_number = multiprocessing.cpu_count() * 2
    threads = list()
    for i in range(thread_number):
        print("Starting thread ", i)
        t = HttpWorker()
        threads.append(t)
        t.start()

    cps_norm = get_rand_cps_int(max_execution_time)
    for cps in cps_norm:
        time.sleep(1)
        max_per_second = cps
        print("Limited ", max_per_second)

    time.sleep(1)
    for t in threads:
        print("Stoping thread")
        t.stop()


def load_config(cnf_name):
    global url, max_execution_time, normal_distribution
    config = yaml.safe_load(open(cnf_name).read())
    url = config["url"]
    max_execution_time = config["max_execution_time"]
    normal_distribution = config["normal_distribution"]


if __name__ == "__main__":
    argp = argparse.ArgumentParser()
    argp.add_argument("-c", "--config", dest='config_file', default='config.yml', type=str)
    args = argp.parse_args()
    config_file = args.config_file
    if os.path.isfile(config_file):
        load_config(config_file)
    else:
        print("No such config file.")
        sys.exit(-1)
    main()
