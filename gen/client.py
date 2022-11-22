import socket
import argparse
import time
import random
import numpy as np
import logging
from datetime import datetime

logging.basicConfig(filename='example.log',level=logging.DEBUG)

parser = argparse.ArgumentParser(description='Traffic Generetor Python')
parser.add_argument('--type',dest="type", type=str ,help='udp or tcp',default='udp')
parser.add_argument('--add',dest="add", type=str ,help='address of the server',default="0.0.0.0")
parser.add_argument('--port',dest="port",type=int , help='port on the server',default="10002")
parser.add_argument('--size',dest="size",type=int , help='size of packets in bytes',default="100")
parser.add_argument('--interval',dest="interval",type=float , help='interval between packets in ms',default="10")
parser.add_argument('--mode',dest="mode",type=str , help='time disterbution e exp, f fixed',default="f")


args = parser.parse_args()

if args.size < 10:
    args.size == 10

if args.type == "udp":
    try:
        sock = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
        while True:
            sock.sendto(bytes(str(time.time()),'utf-8').zfill(args.size), (args.add, args.port))
            if args.mode == "e":
                exp_dis =np.log( 1 - np.random.random() )/(-1 *(1/args.interval))
                time.sleep(exp_dis*0.001)
               # logging.debug(datetime.utcnow())
            else:
                time.sleep(args.interval*0.001)

    except socket.error as err: 
        print ("socket creation failed with error %s" %(err) ) 
if args.type == "tcp":
    try:
        sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        sock.connect((args.add,args.port))
        while True:
            sock.sendall(bytes(str(time.time()),'utf-8').zfill(args.size))
            if args.mode == "e":
                exp_dis =np.log( 1 - np.random.random() )/(-1 *(1/args.interval))
                time.sleep(exp_dis*0.001)
            else:
                time.sleep(args.interval*0.001)
    except socket.error as err: 
        print ("socket creation failed with error %s" %(err) )


