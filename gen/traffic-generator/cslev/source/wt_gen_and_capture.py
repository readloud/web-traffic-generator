#!/usr/bin/python3
# coding: utf-8


import os
import pandas as pd
from selenium import webdriver
from selenium.common.exceptions import TimeoutException , WebDriverException
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary # for specifying the path to firefox binary
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from time import sleep,ctime
import multiprocessing
import time
import datetime
import argparse
from argparse import RawTextHelpFormatter
import json


def getDateFormat(timestamp):
    '''
    This simple function converts traditional UNIX timestamp to YMD_HMS format
    timestamp int - unix timestamp to be converted
    return String - the YMD_HMS format as a string
    '''
    return datetime.datetime.\
        fromtimestamp(float(timestamp)).strftime('%Y%m%d_%H%M%S')


#get current timestamp and convert it
ts = time.time()
timestamp = getDateFormat(str(ts))

# WORKDIR_PREFIX="/doh_project/work_dir/"
WORKDIR_PREFIX="./"

# parser for the command line arguements
parser = argparse.ArgumentParser(description="DoH packet capture and .csv conversion script!",formatter_class=RawTextHelpFormatter)

parser.add_argument('-s', action="store", default=1, type=int, dest="start" , help="Specify rank of the starting website (Default: 1)")
parser.add_argument('-e', action="store", default=5000, type=int, dest="end" , help="Specify rank of the ending website (Default: 5000)")
parser.add_argument('-b', action="store", default=200, type=int, dest="batch" , help="Batch Size (range must be a multiple of batch size! - default: 200)")
parser.add_argument('-q', action="store_true",dest="quic", help="Enable QUIC in Firefox (Default: False)")
parser.add_argument('-d', action="store", default="top-1m.csv", type=str, dest="domain_list" , help="Path to file containing the domains to visit (Default: top-1m.csv)")
parser.add_argument('-r', action="store", default="DISABLED", type=str, dest="doh_resolver" ,
                    help="DoH resolver (incase sensitive):\n" +\
                    "\tDISABLED\n" +\
                    "\tCloudflare\n" +\
                    "\tGoogle\n" +\
                    "\tCleanBrowsing\n" +\
                    "\tQuad9\n" +\
                    "\tPowerDNS\n" +\
                    "\tdohli\n" +\
                    "\tAdGuard\n" +\
                    "\tOpenDNS\n" +\
                    "\tComcast\n" +\
                    "\tCZNIC\n" +\
                    "\tDNSlify\n" +\
                    "\tBlahdns\n" +\
                    "\tffmucnet\n" +\
                    "\tContainerPI\n" +\
                    "\tTiarap\n" +\
                    "\tDNSSB\n" +\
                    "\ta42l\n" +\
                    "\ta_and_a\n" +\
                    "\ttwnic\n" +\
                    "\tdigital\n" +\
                    "\tLibreDNS\n" +\
                    "\tpi_dns\n" +\
                    "\tflatuslifir\n" +\
                    "\the_net\n" +\
                    "\talibaba\n" +\
                    "\talekberg_es\n" +\
                    "\talekberg_nl\n" +\
                    "\talekberg_se\n" +\
                    "\tbravedns\n" +\
                    "\tcs_private\n" +\
                    "\tcs_protected\n" +\
                    "\tcs_family\n" +\
                    "\tdnsforge\n" +\
                    "\tdnshome\n" +\
                    "\tfaelix\n" +\
                    "\tapplied_privacy\n" +\
                    "\thostux_unc\n" +\
                    "\thostux_adb\n" +\
                    "\tlelux\n" +\
                    "\tnekomimi\n" +\
                    "\trubyfish\n" +\
                    "\tsnopyta\n" +\
                    "\tswitch\n" +\
                    "\tchantra\n" +\
                    "\tnull31\n" +\
                    "\tpublic_array\n")
parser.add_argument('-i', '--interface', nargs=1,
                    help="Specify the interface to use for capturing",
                    required=False,
                    default=['eth0'])
parser.add_argument('-t', '--timeout', action="store", default=16, type=int, dest="timeout",
                    help="Specify the timeout for a webpage to load (Default: 16)")
parser.add_argument('-a', '--assembly-segments', action="store_true", dest="tso_on",
                    help="Specify if reassembly IS desired in the csv files (Default: False)")
parser.set_defaults(tso_on=False)
parser.add_argument('-k', '--keep-pcaps', action="store_true", dest="keep_pcaps",
                    help="Specify if pcap files SHOULD BE KEPT (Default: False)")
parser.set_defaults(keep_pcaps=False)
parser.set_defaults(quic=False)

results = parser.parse_args()


# setup logging features
log_file = str(WORKDIR_PREFIX)+"log_"+str(timestamp)
print("Creating log file "+log_file)
logs = open(log_file, 'a')
logs.write("Logging for doh_capture.py started on "+timestamp+"\n\n")

# remove previous symlink if there was any
if os.system("rm -rf "+str(WORKDIR_PREFIX)+"progress.log") == 0:
    print("symlink to previous log file has been deleted")
    logs.write("symlink to previous log file has been deleted\n")
else:
    print("symlink to previous log file could NOT be deleted")
    logs.write("symlink to previous log file could NOT be deleted\n")

# create symlink to the new log file
if os.system("ln -s log_"+str(timestamp)+" "+str(WORKDIR_PREFIX)+"progress.log") == 0:
    print("creating symlink progress.log to "+str(log_file)+" is successfull")
    logs.write("creating symlink progress.log to "+str(log_file)+" is successfull\n")
else:
    print("creating symlink progress.log to "+str(log_file)+" was NOT successfull")
    logs.write("creating symlink progress.log to "+str(log_file)+" was NOT successfull\n")


def get_resolver_details(resolver) :
    with open('r_config.json') as f:
        resolver_config = json.load(f)
        # print(resolver_config)
    try:
        return resolver_config[resolver]["simple_name"], resolver_config[resolver]["uri"], resolver_config[resolver]["bootstrap"]
    except:
        print("Uknown resolver ID {}".format(resolver))
        print("Exiting...")
        exit(-1)



start = results.start
stop = results.end
batch_size = results.batch
time_out = batch_size * 15
interface = results.interface[0]
webpage_timeout = int(results.timeout)
resolver=str(results.doh_resolver).lower()
domain_list=results.domain_list
quic = results.quic
#counters for future references to log how many domains failed and did not resolver properly
error=0
timeout=0

#arguments to be passed to csv_generator.py - TSO: tcp segmentation offload 
# (if enabled, which is by default, then we have to set -a for csv_generator to let it know
# packets might be bigger than 1500-byte due to desegmentation
if(results.tso_on):
    TSO_ON = ' -a '
else:
    #if TSO is disabled, intentionally with ethtool on the given interface, csv_generator, or more precisely the tshark command
    # later on has to have additional filtering arguments
    TSO_ON = ' '

if(results.keep_pcaps):
    KEEP_PCAPS=' -k '
else:
    KEEP_PCAPS=' '
#-------------------------------------------

if resolver != "disabled":
    resolver_name, uri , bootstrap = get_resolver_details(resolver)
else:
    resolver = False

# Fine-tune batch size if it is bigger than stop-start
max_possible_batch_size = stop-start+1
if (batch_size > max_possible_batch_size):
    batch_size = max_possible_batch_size


print("Printing script Parameters: ")
logs.write("Printing script Parameters: \n")
print("Start = "+str(start))
logs.write("Start = "+str(start)+"\n")
print("End = "+str(stop))
logs.write("End = "+str(stop)+"\n")
print("(Adjusted) Batch_Size = "+str(batch_size))
logs.write("(Adjusted) Batch_Size = "+str(batch_size)+"\n")
if resolver:
    print("DoH:")
    print("\tResolver:"+str(resolver_name))
    print("\tURI:"+str(uri))
    print("\tBootstrap IP:"+str(bootstrap))
    logs.write("DoH:\n")
    logs.write("\tResolver:"+str(resolver_name)+"\n")
    logs.write("\tURI:"+str(uri)+"\n")
    logs.write("\tBootstrap IP:"+str(bootstrap)+"\n")
else: #resolver disabled
    print("\tNo DoH resolver configured, fallback to default DNS")
    logs.write("\tNo DoH resolver configured, fallback to default DNS\n")

if quic:
    print("QUIC: ENABLED")
    logs.write("QUIC: ENABLED\n")
else:
    print("QUIC: DISABLED")
    logs.write("QUIC: DISABLED\n")


print("\tKEEP PCAPS: " + str(results.keep_pcaps))
logs.write("\tKEEP PCAPS: " + str(results.keep_pcaps)+"\n")
print("\tTSO ON: " + str(results.tso_on))
logs.write("\tTSO_ON: " + str(results.tso_on)+"\n")



print("List of domains to visit (file):"+str(domain_list))
logs.write("List of domains to visit (file):"+str(domain_list)+"\n")

#----------- UPDATE FROM HERE
data = pd.read_csv(domain_list , names = ['rank','website'])

print("Process started: " + str(time.ctime()))
logs.write("Process started: " + str(time.ctime())+"\n\n\n")

options = Options()
options.headless = True
#seems, we have to specify location this way, too - 
options.binary_location = "./firefox/firefox"


## specifying the binary path
binary = FirefoxBinary('./firefox/firefox')



## DesiredCapabilities
#cap = DesiredCapabilities().FIREFOX
#cap['marionette'] = False

#profile = webdriver.FirefoxProfile('/home/user/.mozilla/firefox/0b5055qu.Doh_profile')
## setting the firefox profile to use DoH

#########
### NOTE
#########
# profile IS DEPRECATED COMPARED TO service HOWEVER SERVICE VARIANT CRASHES MORE OFTEN WITH THE GECKODRIVER 
# - hence reverted back to profile - still works with selenium bundled in the container

profile = webdriver.FirefoxProfile()
# service = Service("./geckodriver") #maybe set path to geckodriver here

if resolver:
    profile.set_preference("network.trr.mode", 3)
    profile.set_preference("network.trr.uri", uri)
    # profile.set_preference("network.trr.bootstrapAddress", bootstrap)
    # options.set_preference("network.trr.mode", 3)
    # options.set_preference("network.trr.uri", uri)
    # options.set_preference("network.trr.bootstrapAddress", bootstrap)
else:
    profile.set_preference("network.trr.mode", 0)
    # options.set_preference("network.trr.mode", 0)

#Use quic if required
if quic:
    profile.set_preference("network.http.http3.enable_0rtt", True)
    profile.set_preference("network.http.http3.enable", True)
    profile.set_preference("network.http.http3.priorty", True)

    # options.set_preference("network.http.http3.enable_0rtt", True)
    # options.set_preference("network.http.http3.enabled", True)
else: #definitely disable quic if not needed
    profile.set_preference("network.http.http3.enable_0rtt", False)
    profile.set_preference("network.http.http3.enable", False)
    # options.set_preference("network.http.http3.enable_0rtt", False)
    # options.set_preference("network.http.http3.enabled", False)



logs.flush()



def open_website(url,count):
    tmp_ts = time.time()
    tmp_timestamp = getDateFormat(str(tmp_ts))
    global error
    global timeout
    

    ## in the executabel path you need to specify the location of geckodriver location.
    try:
        driver = webdriver.Firefox(options=options, firefox_profile=profile)
        # driver = webdriver.Firefox(options=options, service=service)
        driver.set_page_load_timeout(webpage_timeout)
    except WebDriverException as ex:
        print("Error during loading the driver (website skipped): " + str(ex))
        logs.write("Error during loading the driver (website skipped): " + str(ex) + "\n")
    try :
        driver.get(url)
        print(str(count)+" "+url+" (visited: "+str(tmp_timestamp)+")")
        logs.write(str(count)+" "+url+" (visited: "+str(tmp_timestamp)+")\n")
        sleep(2)
    except TimeoutException as ex1 :
        print("TimeoutException Exception has been thrown "+ str(ex1))
        sleep(2)
        logs.write("TimeoutException Exception has been thrown \n"+str(ex1)+"\n")
        timeout = timeout + 1 #increase timeout counter
        print("Timeouts so far (in this batch): " + str(timeout))
        logs.write("Timeouts so far (in this batch): "+str(timeout)+"\n")
    except WebDriverException as ex2 :
        print("WebDriverException Exception has been thrown "+ str(ex2))
        sleep(2)
        logs.write("WebDriverException Exception has been thrown \n"+str(ex2)+"\n")
        error = error + 1 #increase error counter 
        print("Errors so far (in this batch): " + str(error))
        logs.write("Errors so far (in this batch): "+str(error)+"\n")
    except Exception as ex3:
        print("Unknown exception has been thrown "+ str(ex3))
        sleep(2)
        logs.write("Unknown exception has been thrown \n"+str(ex3)+"\n")
    logs.flush()
    try:
        driver.close()
        sleep(1)
    except WebDriverException as ex:
        print("Error during closing the driver (continue): " + str(ex))
        logs.write("Error during closing the driver (continue): " + str(ex) + "\n")


def main_driver(s,e) :
    count = s
    df = data.iloc[s-1:e]
    for domain in df['website'] :
        url = 'https://www.' + domain
        open_website(url,count)
        count = count + 1

    print("batch completed")
    logs.write("batch completed"+"\n")
    logs.flush()


s = start
e = s+batch_size-1



def capture_packets(shell_command):
    os.system(shell_command)



current_batch=1
while(s<=stop) :
    if(e>stop) :
        e=stop

    filename = str(WORKDIR_PREFIX)+"pcap/capture-"+str(current_batch)+"-"+str(s)+"-"+str(e)

    ## here after -i you need to add the ethernet port. which i guess is eth0
    shell_command = "/usr/bin/tcpdump port '(53 or 443)' -i " + interface + " -w " + filename

    t1 = multiprocessing.Process(target=main_driver, args=(s,e))
    t2 = multiprocessing.Process(target=capture_packets, args=(shell_command,))

    t2.start()
    sleep(3)
    t1.start()

    t1.join()
    sleep(5)
    t2.terminate()
    print("Killing tcpdump via pkill...")
    logs.write("Killing tcpdump via pkill...\n")
    os.system("pkill tcpdump")

    print("Done")
    logs.write("Done"+"\n")
    logs.flush()
    sleep(2)
    # print(time.ctime())
    # logs.write(time.ctime()+"\n")
    logs.flush()
    s = s+batch_size
    e = e+batch_size
    current_batch += 1

    print("Running pcap file analyser to create csv files...")
    logs.write("Running pcap file analyser to create csv files...\n")

    # csv_command = "python3 csv_generator.py -l "+log_file + TSO_ON + KEEP_PCAPS
    csv_command = "python3 csv_generator.py -l "+ log_file + " -i " + filename + " " + KEEP_PCAPS + " " + TSO_ON
    os.system(csv_command)
    sleep(1)

print("Re-printing script Parameters: ")
logs.write("Re-printing script Parameters: \n")
print("Start = "+str(start))
logs.write("Start = "+str(start)+"\n")
print("End = "+str(stop))
logs.write("End = "+str(stop)+"\n")
print("(Adjusted) Batch_Size = "+str(batch_size))
logs.write("(Adjusted) Batch_Size = "+str(batch_size)+"\n")
if resolver: 
    print("DoH:")
    print("\tResolver:"+str(resolver_name))
    print("\tURI:"+str(uri))
    logs.write("DoH:\n")
    logs.write("\tResolver:"+str(resolver_name)+"\n")
    logs.write("\tURI:"+str(uri)+"\n")
else: #resolver disabled
    print("\tNo DoH resolver configured, fallback to default DNS")
    logs.write("\tNo DoH resolver configured, fallback to default DNS\n")

if quic:
    print("QUIC: ENABLED")
    logs.write("QUIC: ENABLED\n")
else:
    print("QUIC: DISABLED")
    logs.write("QUIC: DISABLED\n")

print("\tKEEP PCAPS: " + str(results.keep_pcaps))
logs.write("\tKEEP PCAPS: " + str(results.keep_pcaps)+"\n")
print("\tTSO ON: " + str(results.tso_on))
logs.write("\tTSO_ON: " + str(results.tso_on)+"\n")



# print("\nNumber of webpages failed to load/resolve the domain for: "+str(error))
# logs.write("\nNumber of webpages failed to load: "+str(error)+"\n")
# print("\nNumber of webpages timed out: "+str(timeout))
# logs.write("\nNumber of webpages timed out: "+str(timeout)+"\n")


logs.close()
