'''
Modified from LagrangianGui.py by Pavan Vattyam and Yanbanhui Liu
'''

from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
import pyqtgraph as pg
import sys
import numpy as np
from DataHandler import Client
import pickle
import time

class QThread1(QThread):
    sig1 = pyqtSignal(list)

    def __init__(self, parent=None):
        QThread.__init__(self, parent)
        self.running = False

    # runs in the background
    def run(self):
        self.running = True

        while self.running:
            print("running")

            try:
                gang = Client()
                c = gang.receiveData(False)
                self.running = False
                gang.close()
                c = pickle.loads(c)
                self.sig1.emit(c)
            except:
                print("No data received")
            time.sleep(3)

    def stop(self):
        self.running = False

class MainWidget(QWidget):

    def __init__(self, *args, **kwargs):

        self.connected = False
        super(MainWidget, self).__init__(*args, **kwargs)

        c1 = QFrame()
        c2 = QFrame()
        c3 = QFrame()
        self.lblOK = []
        # box1 widgets
        for i in range(4):
            self.lblOK.append(QLabel("WAITING"))
            self.lblOK[i].setStyleSheet("QLabel{color: blue;}")

        self.btSock = QPushButton('connect')
        self.btSock.clicked.connect(self.sockConnect)

        layout1 = QFormLayout()
        layout1.addRow(QLabel("Status information : "))
        layout1.addRow(QLabel("DAC convertor : "), self.lblOK[0])
        layout1.addRow(QLabel("ADC convertor : "), self.lblOK[1])
        layout1.addRow(QLabel("WIFI connection : "), self.lblOK[2])
        layout1.addRow(QLabel("Link established : "), self.lblOK[3])
        layout1.addRow(self.btSock)

        c1.setLayout(layout1)
        c1.setStyleSheet("QLabel {font-size: 30px;}")
        c1.setFrameShadow(QFrame.Sunken)
        c1.setFrameShape(QFrame.Box)

        # box 2 widgets
        self.lblDepth = QLabel("0.0")
        self.eCheck = QCheckBox("EEPROM")

        self.spinDepth = QSlider(Qt.Horizontal)
        self.spinDepth.setMaximum(20)
        self.spinDepth.setMinimum(0)
        self.spinDepth.setTickPosition(QSlider.TicksBelow)
        self.spinDepth.valueChanged.connect(self.sliderChange)

        self.btSetDepth = QPushButton("Send Depth")
        self.btSetDepth.clicked.connect(self.sendDepth)

        layout2 = QFormLayout()
        layout2.addRow(QLabel("Goal Depth (m) : "), self.lblDepth)
        layout2.addRow(self.eCheck)
        layout2.addRow(self.spinDepth)
        layout2.addRow(self.btSetDepth)
        # layout2.addRow(self.canvas)
        c2.setLayout(layout2)
        self.data = np.zeros(20).tolist()
        self.x = self.data
        graphWidget = pg.PlotWidget()
        graphWidget.setYRange(-5, 2)
        graphWidget.setTitle("Position")
        graphWidget.setBackground('w')
        self.plot = graphWidget.plot(self.data, pen='k')

        pen = pg.mkPen(color=(255, 0, 0))

        container = QHBoxLayout()
        container.addWidget(c1)
        container.addWidget(c2)
        c3.setLayout(container)
        container2 = QVBoxLayout()
        container2.addWidget(c3)
        container2.addWidget(graphWidget)

        self.setStyleSheet(
            "QLabel {font-size: 20px; } QPushButton {font-size : 20px;} QCheckBox {font-size : 14px;} QDoubleSpinBox {font-size : 16px;}")
        self.setLayout(container2)
        self.setGeometry(10, 10, 1280, 720)

        self.connected = False
        self.thread1 = QThread1()

    def sliderChange(self):
        self.lblDepth.setText(str(self.spinDepth.value()/10.0))

    def sockConnect(self):  # for initial status
        # 0 = NOT CONNECTED, 1 = CONNECTED
        try:
            gang = Client()
            c = gang.receiveData(True)
            gang.close()
            print(c)
        except:
            c = "S0000"
        if (c[0] == "S"):
            for i in range(4):
                if (int(c[i + 1]) == 1):
                    self.connected = True
                    self.lblOK[i].setText("CONNECTED")
                    self.lblOK[i].setStyleSheet("QLabel {color:green; }")
                else:
                    self.lblOK[i].setText("FAILED")
                    self.lblOK[i].setStyleSheet("QLabel {color:red; }")
        if (self.connected):
            print("connected")
            self.btSock.setDisabled(True)

    def sendDepth(self):
        sender = Client()
        depth = pickle.dumps(self.spinDepth.value())
        sender.sendData(depth)
        print("Depth sent")
        sender.close()
        self.thread1.sig1.connect(self.outData)  # starts getting data
        self.thread1.start()

    def outData(self, data):
        self.plot.setData(data) # Update graph

def main():
    app = QApplication(sys.argv)
    app.setStyle("windows")
    window = MainWidget()
    window.show()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()