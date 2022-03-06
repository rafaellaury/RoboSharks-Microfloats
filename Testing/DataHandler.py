"""
Modified from orignal file by Pavan Vattyam.
Date: 7/18/2019
Purpose: Client class for networking
"""

import socket


class Client:
    def __init__(self):
        self.HOST = socket.gethostname()  # changed from Pi address
        self.PORT = 9000  # Port
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.connect((self.HOST, self.PORT))

    def receiveData(self, decode):
        data = self.s.recv(1024)
        # checks if data is an array or not
        if (decode):
            if (data):
                return data.decode('ascii')
            return -1
        else:
            if (data):
                return data
            return -1

    def sendData(self, data, encode=False):  # Sends data
        if encode:
            self.s.send(data.encode('ascii'))
        else:
            self.s.send(data)
    def close(self):
        self.s.close()