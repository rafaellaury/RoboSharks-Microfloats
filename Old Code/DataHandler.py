"""
Author: Pavan Vattyam
Date: 7/18/2019
Purpose: Client class for networking
"""


import socket
import struct

class Client:
    def __init__(self):
        self.HOST = '143.215.100.229'       # PI ip address
        self.PORT = 9000                    # Port
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.connect((self.HOST, self.PORT))
       

    def receiveData(self,decode):
        data = self.s.recv(1024)     
        #checks if data is an array or not
        if(decode):
            if(data):
                return data.decode('ascii')
            return -1
        else:
            if(data):
                return data
            return -1

            
    def sendData(self,data):    #Sends data
        self.s.send(data.encode('ascii'))

    def sendCommand(self, motorRPM, directionV, durationV):
        commandData = struct.pack('iii', motorRPM, directionV, durationV)
        self.s.sendall(commandData)

    def close(self):
        self.s.close()