"""A Web Traffic Generator based on SURGE, Statistics and Locust.

WTG-SEAL is a web traffic generator based on a statistical approach
inspired by SURGE and implemented using Locust.

"""

from pkg_resources import DistributionNotFound, get_distribution

try:
    # Change here if project is renamed and does not equal
    # the package name
    dist_name = 'wtg-seal'
    dist_url = 'https://github.com/mchoji/wtg-seal'
    __version__ = get_distribution(dist_name).version
except DistributionNotFound:    # pragma: no cover
    __version__ = 'unknown'
finally:
    del get_distribution, DistributionNotFound
