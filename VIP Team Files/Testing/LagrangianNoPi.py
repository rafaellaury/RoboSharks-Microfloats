'''
Modified from Lagrangian.py. All GPIO references removed for testing sockets only without a working Pi.
'''
import socket
import time
import pickle
import threading
import numpy as np

def getStatusInfo():
    global serversocket

    msg = []

    serversocket.settimeout(5.0)

    # get local machine name
    host = socket.gethostname()
    port = 9000

    # bind to the port
    serversocket.bind((host, port))

    # queue up to 5 requests
    serversocket.listen(4)

    msg.append("S")
    msg.append("0")
    msg.append("0")

    # establish a connection
    print(host)
    clientsocket = None
    addr = None
    while(clientsocket == None):
        try:
            clientsocket, addr = serversocket.accept()
        except KeyboardInterrupt:
            return
        except socket.timeout:
            continue

    print("Got a connection from %s" % str(addr))
    msg.append("1")
    msg.append("1")
    message = ''.join(msg)

    clientsocket.send(message.encode('ascii'))

    clientsocket.close()

def receiveDepth():
    global serversocket
    global depth_goal
    serversocket.listen(5)

    clientsocket = None
    addr = None
    while (clientsocket == None):
        try:
            clientsocket, addr = serversocket.accept()
        except KeyboardInterrupt:
            return
        except socket.timeout:
            print("Waiting for depth")
    data = clientsocket.recv(1024)
    depth_goal = (pickle.loads(data) / 10.0)
    clientsocket.close()

def collectData(pressure):
    global ptime
    global pdata
    if (time.process_time() - ptime >= 1.0):
        ptime = time.clock()
        pdata.append((ptime, pressure))


def connect():
    global serversocket
    msg = []

    # queue up to 5 requests
    serversocket.listen(5)

    try:
        clientsocket, addr = serversocket.accept()
    except socket.timeout as e:
        return

    with clientsocket:
        print("Got a connection from %s" % str(addr))
        data = np.random.randint(-4, 0, 20).tolist()
        message = pickle.dumps(data)
        print(data)
        clientsocket.send(message)

        clientsocket.close()

if __name__ == "__main__":
    depth_goal = 0.0
    ptime = time.process_time()
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    getStatusInfo()
    while True:
        receiveDepth()
        connect()