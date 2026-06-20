import time
import pandas as pd
import random
from fake_traffic import fake_traffic

fake_traffic(country='ID', language='id-ID', category='h', threads=2, min_wait=5, max_wait=10, debug=True)
print('***Web Page Visited***')