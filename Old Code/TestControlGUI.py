import tkinter as tk
import numpy as np
from tkinter import *
from tkinter import ttk
from threading import *

from DataHandler import Client
import pickle

import socket
import struct
import time

#GUI for controlling the MicroFloat. This GUI uses Tkinter, for any
#developers that do not have experience with it, please read up here:
#https://www.python-course.us/python_tkinter.php

lblOK = [] #Global Array of labels that each hold the status of a connection to the Rapspberry Pi

class Application(Frame):

    #GUI Application for testing control of MicroFloat
    def __init__(self, master):

        Frame.__init__(self, master)
        self.connected = False #Var for whether connection to Raspberry Pi was successful.

        # Calling function that creates all the various gui controls/sections for the app
        self.createWidgets()

    #Connection Function:
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
                    lblOK[i].config(text = 'CONNECTED')
                    lblOK[i].config(fg = 'green')
                else:
                    lblOK[i].config(text = 'FAILED')
                    lblOK[i].config(fg = 'red')
        if(self.connected):
            print("Connection to Raspberry Pi was successful. Data can be received.")
        else:
            print("Connection to Raspberry Pi was unsuccessful. Data cannot be received.")

    #Threading for process
    def threading(self):
        t1 = Thread(target=self.sockConnect)
        t1.start()

    #Creating widgets for GUI
    def createWidgets(self):
        #Creating and Placing Title
        guiTitle = StringVar()
        label = Label(root, textvariable=guiTitle, font=14)
        guiTitle.set("MicroFloat Control Center")
        label.pack()

        #Creating Sub-Sections: Manual Input Based Control & Pre-Determined Sequence Control
        frame0 = tk.Frame(root)
        separator0 = ttk.Separator(root, orient='horizontal')
        frame1 = tk.Frame(root)
        separator = ttk.Separator(root, orient='horizontal')
        frame2 = tk.Frame(root)
        frame0.pack(side='top', fill='both', expand=True)
        separator0.pack(side='top', fill='x')
        frame1.pack(side='top', fill='both', expand=True)
        separator.pack(side='top', fill='x')
        frame2.pack(side='top', fill='both', expand=True)

        tk.Label(frame0, text='Connections:').pack(side = TOP, anchor = NW)
        tk.Label(frame0, text='Data:').place(x=200, y = 0)
        tk.Label(frame1, text='Manual Input Based Control').pack()
        tk.Label(frame2, text='Pre-determined Sequence Control').pack()

        #Creating controls within Section 'Connections'
        # 'Connections' allows for Users to connect to the Rapsberry Pi from the topside computer
        # running the GUI.
        
        #Placing status connection labels in lblOK array var.
        posY = 42
        for i in range(4):
            status = tk.Label(root, text='WAITING', fg='blue')
            status.place(x=120, y=posY)
            lblOK.append(status)
            posY += 20
        
        # Placing connection names.
        Label(root, text='DAC Convertor:').place(x=15, y=42)
        Label(root, text='ADC Convertor:').place(x=15, y=62)
        Label(root, text='WiFi Connection:').place(x=15, y=82)
        Label(root, text='Link Established:').place(x=15, y=102)

        # Button for attempting to connect to the Raspberry Pi.
        buttonConnect=tk.Button(root, command=self.threading, text="Connect")
        buttonConnect.place(x=120, y=120)

        #Creating controls within Section 'Manual Input Based Control'
        # 'Manual Input Based Control' allows for Users to have direct control 
        # over how the MicroFloat moves:

        #Slider for controlling % of max motor rpm
        motorRPM = IntVar(value=0)
        scale = Scale(root, variable = motorRPM, orient = HORIZONTAL, label = "% of max motor rpm", length = 120)
        scale.place(x=25, y=170)

        #RadioButtons to decide whether the MicroFloat will rotate Clockwise (CW) or Counter Clockwise (CCW)
        directionVar = IntVar(value=0)
        Radiobutton(root, text="CW", variable=directionVar, value = 1).place(x=225, y=190)
        Radiobutton(root, text="CCW", variable=directionVar, value = 2).place(x=225, y=240)
        Label(root, text='Direction').place(x=225, y=170)

        #User may enter how long the manually-entered controls will occur for
        vcmd = (self.register(self.validateTime))
        timeVar = StringVar(value=0)
        Entry(root, textvariable=timeVar, validate='all', validatecommand=(vcmd, '%P')).place(x=365, y=200)
        Label(root, text='Duration (in sec)').place(x=365, y=170)

        #Helper function for clearing manual sequence input
        def clearManual():
            motorRPM.set(0.0)
            directionVar.set(0)
            timeVar.set(0)

        #Button for clearing manual sequence input
        manualClear=tk.Button(root, command=lambda: clearManual(), text="Clear")
        manualClear.place(x=350, y=230)

        #Button for running the MicroFloat based on the manual controls entered.
        manualRun=tk.Button(root, command=lambda: self.runSequenceCustom(motorRPM, directionVar, timeVar), text="Run", fg='blue')
        manualRun.place(x=425, y=230)

        #Creating controls within Section 'Pre-Determined Sequence Control'
        # 'Pre-Determined Sequence Control' does not take in any manually entered inputs for control.
        # Instead, it allows the user to select among an option of pre-determined movements:

        #RadioButtons that allow the user to select among an option of pre-determined movements:
        sequenceOption = IntVar(value=0)
        Radiobutton(root, text="Continuous Dive", variable=sequenceOption, value = 1).place(x=25, y=300)
        Radiobutton(root, text="Continuous Rise", variable=sequenceOption, value = 2).place(x=200, y=300)
        Radiobutton(root, text="Bleed Air", variable=sequenceOption, value = 3).place(x=375, y=300)
        Radiobutton(root, text="Quick Dive", variable=sequenceOption, value = 4).place(x=25, y=330)
        Radiobutton(root, text="Quick Rise", variable=sequenceOption, value = 5).place(x=200, y=330)
        Radiobutton(root, text="Terminate", variable=sequenceOption, value = 6).place(x=375, y=330)

        #Button for clearing pre-determined sequence input
        autoClear=tk.Button(root, command=lambda: sequenceOption.set(0), text="Clear")
        autoClear.place(x=350, y=360)

        #Button for running the MicroFloat based on the pre-determined sequence chosen.
        autoRun=tk.Button(root, command=lambda: self.runSequencePreset(sequenceOption), text="Run", fg='blue')
        autoRun.place(x=425, y=360)

    #Callback function to validate that input to the time entry is a number
    def validateTime(self, P):
        if str.isdigit(P) or P == "":
            return True
        else:
            return False

    #Callback function for running a custom sequence.
    # ONLY USED FOR MANUAL CONTROL
    def runSequenceCustom(self, motorRPM, directionVar, timeVar):
        print("rpm: %d --- direction: %d --- time: %s" %(motorRPM.get(), directionVar.get(), timeVar.get()))
        durationVar = int(timeVar.get())
        try:
            print("Sending Command")
            gang = Client()
            gang.sendCommand(motorRPM.get(), directionVar.get(), durationVar)
            gang.close()
        except:
            print("ERROR: Unable to send command to the Rapsberry Pi.")

    # Function that sends data for preset Sequence to Client
    # ONLY USED FOR PRESET/PRE-DETERMINED SEQUENCE CONTROL
    def runPreset(self, motorRPM, directionVar, timeVar):
        print("rpm: %d --- direction: %d --- time: %s" %(motorRPM, directionVar, timeVar))
        try:
            print("Sending Command")
            gang = Client()
            gang.sendCommand(motorRPM, directionVar, timeVar)
            gang.close()
        except:
            print("ERROR: Unable to send command to the Rapsberry Pi.")

        
    #Callback function for running a preset sequence

    #IMPORTANT:
        # Please use ' runPreset() ' with valid hardcoded arguments for your specific preset sequence
        # The function expects int values for each argument. 
        # IMPORTANT: directionVar expects a hardcoded value of either 1 or 2. 
        #   1 == CW (Clockwise) and 2 == CCW (Counter-Clockwise)

    def runSequencePreset(self, sequenceOption):
        if sequenceOption.get() == 1:
            print("Continuous Dive")
            self.runPreset(100, 1, 20)  
        elif sequenceOption.get() == 2:
            print("Continuous Rise")
            self.runPreset(100, 2, 20)
        elif sequenceOption.get() == 3:
            #need to clarify exactly what bleed air is
            print("Bleed Air")
        elif sequenceOption.get() == 4:
            print("Quick Dive")
            self.runPreset(200, 1, 10)
        elif sequenceOption.get() == 5:
            print("Quick Rise")
            self.runPreset(200, 2, 10)
        elif sequenceOption.get() == 6:
            print("Terminate")
            self.runPreset(0, 0, 0)
            # clearManual()
            # Question: does time need to be a positive number for terminate?

#Creating Root Window and Application Object
if __name__ == '__main__':
    root = tk.Tk()
    root.geometry("500x400")
    root.resizable(False, False)
    root.title("MicroFloat Control")
    app = Application(root)
    print("Running")
    root.mainloop()
