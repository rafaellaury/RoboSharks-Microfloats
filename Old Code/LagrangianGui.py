#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
Author : Pavan Vattyam, Yanbaihui Liu
Date : 6/25/2019
Purpose: Main gui to interface with the profiler over WIFI
"""
import numpy as np

import matplotlib.pyplot as plt

import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import *

from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.backends.backend_qt5agg import NavigationToolbar2QT as NavigationToolbar
from matplotlib.figure import Figure


from DataHandler import Client
import pickle

import socket
import time

#Receiving data in background
class QThread1(QThread):
    sig1 = pyqtSignal(list)
    def __init__(self, parent=None):
        QThread.__init__(self, parent)
    #runs in the background
    def run(self):
        self.running = True
       
        while self.running:
            print("running")
            
            try:
                gang = Client()
                c = gang.receiveData(False)
                gang.close()
            except:
                c="NULL"
            c = pickle.loads(c)
            
            self.sig1.emit(c)
            time.sleep(3)


class Main(QWidget):
    
    def __init__(self):
        super().__init__()
    
        self.initUI()
        

        self.connected = False
        self.thread1 = QThread1()
        
        
    def initUI(self):
        
        c1 = QFrame()
        c2 = QFrame()

        self.lblOK = []
        #box1 widgets
        for i in range(4):
            self.lblOK.append(QLabel("WAITING"))
            self.lblOK[i].config(fg = 'blue')
        
        self.btSock = QPushButton('connect')
        self.btSock.clicked.connect(self.sockConnect)

        layout1 = QFormLayout()
        layout1.addRow(QLabel("Status information : "))
        layout1.addRow(QLabel("DAC convertor : "),self.lblOK[0])
        layout1.addRow(QLabel("ADC convertor : "),self.lblOK[1])
        layout1.addRow(QLabel("WIFI connection : "),self.lblOK[2])
        layout1.addRow(QLabel("Link established : "),self.lblOK[3])
        layout1.addRow(self.btSock)

        c1.setLayout(layout1)
        c1.setStyleSheet("QLabel {font-size: 30px;}")
        c1.setFrameShadow(QFrame.Sunken)
        c1.setFrameShape(QFrame.Box)
        
        
        #box 2 widgets
        self.lblDepth = QLabel("0.0")
        self.eCheck = QCheckBox("EEPROM")

        self.spinDepth = QDoubleSpinBox()
        self.spinDepth.setMaximum(2.0)
        self.spinDepth.setMinimum(1.0)
        self.spinDepth.setSingleStep(.1)
        self.spinDepth.setSuffix("m")

        self.btSetDepth = QPushButton("Set Depth")
        self.btSetDepth.clicked.connect(self.sliderChange)

        """ self.figure = Figure()
        self.canvas = FigureCanvas(self.figure)
        self.ax = self.figure.add_subplot(111)
        self.ax.set(xlabel='time (s)', ylabel='Depth (m)',title='Profiler Depth')
        self.ax.invert_yaxis()

        t  = (np.arange(4,-.2,-.2))
        t2 = (np.zeros(12) + 4)
        t3 = (np.arange(0,4,.2))
        
       
        self.ax.plot(np.concatenate((t3,t2,t) , axis = None)) """
        
        
        #box 2 adding to layout
        layout2 = QFormLayout()
        layout2.addRow(QLabel("Depth : "), self.lblDepth)
        layout2.addRow(self.eCheck)
        layout2.addRow(self.spinDepth, self.btSetDepth)
        #layout2.addRow(self.canvas)
        c2.setLayout(layout2)

        #box 3 widgets
        
        
        container = QGridLayout()
        container.addWidget(c2,1,2)
        container.addWidget(c1,1,1)
        
        
        self.setWindowTitle('Absolute')	 
        self.setStyleSheet("QLabel {font-size: 20px; } QPushButton {font-size : 20px;} QCheckBox {font-size : 14px;} QDoubleSpinBox {font-size : 16px;}") 
        self.setLayout(container)
        self.setGeometry(10,10,1280,720)

        
    #connect functions--------------------------------------------------------
    
        #TODO: send depth to PI over socket
    def sliderChange(self):
        self.lblDepth.setText(self.spinDepth.text())

    def sockConnect(self): #for initial status
        # 0 = NOT CONNECTED, 1 = CONNECTED
        try:
            gang = Client()
            c = gang.receiveData(True)
            gang.close()
        except:
            c = "S0000"
        if(c[0] == "S"):
            for i in range(4):
                if(int(c[i+1]) == 1):
                    self.connected = True
                    self.lblOK[i].setText("CONNECTED")
                    self.lblOK[i].setStyleSheet("QLabel {color:green; }")
                else:
                    self.lblOK[i].setText("FAILED")
                    self.lblOK[i].setStyleSheet("QLabel {color:red; }")
        if(self.connected):
            print("howdy")
            self.thread1.sig1.connect(self.outData) #starts getting data
            self.thread1.start()
            self.btSock.setDisabled(True)
            
    
    def outData(self, data):
        #pickle.loads(data)
        #for i in data:
            #print(data)
            #self.ax.plot(data)
        # plot data on a poped up interface
        # problem: axis not shown properly after I update graph constantly
        #          try to make it fixed on GUI
        plt.clf()
        l = len(data)
        time = np.arange(l)
        print(time)
        print(data)
        plt.plot(np.asarray(time),np.asarray(data))
        plt.ylabel('Depth (m)')
        plt.xlabel('time (s)')
        plt.pause(.05)
        plt.show()
        
        
        
#Starts the application     
if __name__ == '__main__':
    
    app = QApplication(sys.argv)
    ex = Main()
    ex.show()	
    sys.exit(app.exec_())
