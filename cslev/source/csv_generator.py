#!/usr/bin/python3
# coding: utf-8

# import pandas as pd
# import numpy as np
import os
import argparse
import sys
import re

#getting the ENV files for the SSLKEYLOG
SSLKEY   = os.getenv('SSLKEYLOGFILE')
SSLDEBUG = os.getenv('SSLDEBUGFILE')

# ## tshark -r capture-1-200 -Y "http2" -o tls.keylog_file:sslkey1.log -T fields -e frame.number -e _ws.col.Time -e ip.src -e ip.dst -e _ws.col.Protocol -e frame.len -e _ws.col.Info -E header=y -E separator="," -E quote=d -E occurrence=f > test1.csv

parser = argparse.ArgumentParser(description="csv_generator script")
parser.add_argument('-l', 
                    '--logfile', 
                    dest="logfile",
                    help="Specify the log_file that has been used by quic_doh_capture.py",
                    required=True)
parser.add_argument('-i',
                    '--input',
                    dest="input",
                    help="Specify path to pcap file(s). \n" + 
                    "Use /path/to/csvfiles/capture.pcap to process capture.pcap\n" +
                    "Use /path/to/csvfiles/ to process all .pcap files in "+
                    "in the directory.",
                    required=True)

parser.add_argument('-a', '--assembly-segments', action="store_true", dest="tso_on",
                     help="Specify if reassembly IS desired in the csv files (Default: False)")
parser.set_defaults(tso_on=False)
parser.add_argument('-k', '--keep-pcaps', action="store_true", dest="keep_pcaps",
                    help="Specify if pcap files SHOULD BE KEPT (Default: False)")
parser.set_defaults(keep_pcaps=False)



args = parser.parse_args()
log_file = args.logfile
PATH=args.input
TSO_ON=args.tso_on
KEEP_PCAPS=args.keep_pcaps

# opening the same log file for further logging
logs = open(log_file, 'a')


#we only store the filenames without the exact path in the files list
if(os.path.isdir(PATH)):
  directory_prefix=PATH
  for _,_,files in os.walk(str("{}/".format(PATH))):
    pass
    # print(files)
else:
  f = os.path.basename(PATH)
  files = [f]
  directory_prefix = PATH.split(f)[0]

#add / at the end of directory_prefix to be on the safe side
directory_prefix=directory_prefix+"/"

#cleanup files list
tmp_files = []
for f in files:
  if(re.search("^capture-[0-9]*-[0-9]*-[0-9]*",f)) is not None: #regexp for doh_docker specific capture files only
    tmp_files.append(f)
files = tmp_files


total = len(files)
count = 1
print("Converting .pcap files to .csv")
logs.write("Converting .pcap files to .csv\n")
logs.flush()
for f in files :
  if(re.search("^capture-[0-9]*-[0-9]*-[0-9]*",f)) is not None: #regexp for doh_docker specific capture files only
    file_name = directory_prefix + f
    try:
      # output_file_name = directory_prefix+"csvfile-"+f.split('-')[1] + "-" + f.split('-')[2] +".csv"
      output_file_name = "csvfile-"+f.split('-')[1] + "-" + f.split('-')[2] + "-" + f.split('-')[3] + ".csv"
    except:
      print("Unrecognized file naming pattern for filename {}\nSkipping".format(output_file_name))
      logs.write(str("Unrecognized file naming pattern for filename {}\nSkipping\n".format(output_file_name)))
      continue
    # print(output_file_name)
    # logs.write(str(output_file_name)+"\n")
    # logs.flush()

    ## SETTING UP FILTERING IF TSO IS DISABLED
    ## here in tls.keylog_file: speciy location and name of sslkeylogfile
    extra_filter=' -o tcp.desegment_tcp_streams:false ' # <-- if TSO (TCP Seg. Offload) is disabled intentionally 
    # TSO IS ENABLED, NO NEED TO DO FURTHER FILTERING
    print("TSO ON? : " + str(TSO_ON))
    if(TSO_ON):
        extra_filter=' '
    
    csv_command = 'tshark -r ' + file_name +' -Y "(http2)||(dns and tls)||(tls)||(quic)||(http3)||(dns)||(udp)||(tcp)" -o tls.keylog_file:'+ SSLKEY + extra_filter +' -T fields -e frame.number -e _ws.col.Time -e ip.src -e ip.dst -e tcp.srcport -e tcp.dstport -e udp.srcport -e udp.dstport -e _ws.col.Protocol -e frame.len -e _ws.col.Info -E header=y -E separator="," -E quote=d -E occurrence=f > '+ output_file_name
    print("tshark cmd: "+ csv_command)
    logs.write("tshark cmd: "+ csv_command+"\n")
    logs.flush()

    remove_file = "rm -rf "+ file_name
    try:
      os.system(csv_command)
      print(str(count) + " of " + str(total) + " completed!")
      logs.write(str(count) + " of " + str(total) + " completed!\n\n")
      logs.flush()
    except:
      print("Something went wrong with tshark...")

    if(not KEEP_PCAPS):
      try:
        sys.stdout.write(str("Removing pcap file {}...\r".format(file_name)))
        os.system(remove_file)
        sys.stdout.write(str("Removing pcap file {}...[DONE]\n".format(file_name)))
        sys.stdout.flush()
        logs.write(str("Removing pcap file {}...[DONE]\n".format(file_name)))
        logs.flush()

      except:
        sys.stdout.write(str("Removing pcap file {}...[FAILED]\n".format(file_name)))
        print("Could not delete pcap file...")
        logs.write(str("Removing pcap file {}...[FAILED]\n".format(file_name)))
        logs.flush()


    count+=1

print("csv_generator has finished!")
logs.write("csv_generator has finished!\n\n")
logs.flush()
logs.close()
