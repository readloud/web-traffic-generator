import socket
import argparse
import time

parser = argparse.ArgumentParser(description='Traffic Generetor Python')
parser.add_argument('--type',dest="type", type=str ,help='udp or tcp',default='udp')
parser.add_argument('--add',dest="add", type=str ,help='address of the server',default="0.0.0.0")
parser.add_argument('--port',dest="port",type=int , help='port on the server',default="10002")

args = parser.parse_args()
byteSum = 0
nPackets = 0
latencySum = 0


if args.type == "udp":
    try:
        sock = socket.socket(socket.AF_INET,socket.SOCK_DGRAM) 
        sock.bind((args.add,args.port ))
        start_time = time.time()
        while True:
            data, addr = sock.recvfrom(10000) # buffer size is max MTU 
            byteSum += len(data)
            latency = time.time() - float(data.decode("utf-8").strip("0"))
            latencySum += latency
            nPackets +=1
            if time.time() - start_time >= 1:
                print(time.time() - start_time )
                print ( str(byteSum*8/1000)+" kbps, "+str((latency/nPackets) *1000)+" msec, " +str(nPackets)+" packtes")
                start_time = time.time()
                byteSum = 0
                nPackets =0
                latencySum=0
    except socket.error as err: 
        print ("socket creation failed with error %s" %(err) ) 
if args.type == "tcp":
    try:
        sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        sock.bind((args.add,args.port ))
        sock.listen()
        conn, addr = sock.accept()
        if conn:
            print("connected to ",addr)
            start_time = time.time()
            while True:
                data = conn.recv(10000) 
                if data:
                    byteSum += len(data)
                    nPackets +=1
                    if len(data.decode("utf-8").strip("0")) <= 17: 
                        latency = time.time() - float(data.decode("utf-8").strip("0"))
                        latencySum += latency
                    if time.time() - start_time >= 1:
                        print ( str(byteSum*8/1000)+" kbps, "+str((latency/nPackets) *1000)+" msec, " +str(nPackets)+" packtes")
                        byteSum = 0
                        nPackets =0
                        latencySum=0
                        start_time = time.time()
    except socket.error as err: 
        print ("socket creation failed with error %s" %(err) ) 

        