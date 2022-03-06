### TODO: update to use correct method of toggling GPIO pins
###       add correct pins for i2c and update remaining code to use it for all analog signals
import RPi.GPIO as GPIO
from smbus2 import SMBus
import time
import socket
from requests import get
import pickle
import struct
#I2C over pins 2 and 3
#    12Bit ADC
#      Hall Effect Sensors 1 and 2
#      Pressure Sensor analog input
#    DAC
#      Motor Speed Analog Out




def readPressure():
	#Read from Pressure Sensor    
	pres = read_adc(2)
 
	#currently assuming this returns the voltage so we need to divide it by the max voltage of the system (5V)
	return pres/5.0

def readBuoyancy():

	# read position of piston from hall sensors and return % buoyancy

	b1 = read_adc(Channel = 1)
	b2 = read_adc(Channel = 0)

	return abs(b1-2.5) * 1/2.5

def read_adc(Channel):
            try:
                config = 0x0003 | 0x8000 | 0x0100 | programmable_gain_map[6144]  | channel_map[Channel] | samples_per_second_map[1600]
                                
                #transmit config info
                bus.write_i2c_block_data(ADC_addr, 1, [(config >> 8) & 0xFF, config & 0xFF]) #write to register 1

                time.sleep(1/1600 + .001) #wait 1 sample

                #read value
                chlist = bus.read_i2c_block_data(ADC_addr, 0, 2) #read 2 bytes from register 0
                voltage =  ((chlist[0] << 4) | chlist[1])  * 6144 / 2048.0 / 1000.0

                num = (200/.5)*voltage - 1000
                if(abs(num)<75 or int(num) == 209 or int(num) == 190 or int(num) == 113 or  int(num) == 132 or int(num) == 94):
                        num = 0.0
                return num
            except:
                return 0.0

def getDepth(preassure):
	#P/(pg) = depth
	depth = preassure/(water_density*grav)
	return depth

def setSolenoidValve(val):
    # Retract if val == 0, extend if val == 1
    if (val == 1 or val == GPIO.HIGH):
        GPIO.output(SVpin, GPIO.HIGH)
    elif (val == 0 or val == GPIO.LOW):
        GPIO.output(SVpin, GPIO.LOW)

def writeVoltage(Vout):
        value  = int((4096*Vout)/5.0)
        if(value > 4095):
                value = 4095
        if(value < 0):
                value = 0 
        reg_data = [(value >> 4) & 0xFF, ((value & 0xF) << 4) & 0xFF]
        #reg_data = [int(value/16), (value % 16) << 4]
      
        bus.write_i2c_block_data(DAC_addr,0x60,reg_data)

def setMotor(enable, direction, rpm):                 
    speedRange = 11285
    rpm = rpm / 100
    rpm = 500 * rpm                                # this if for a 7 pole pair motor with DIP Switch S7 on
    if enable == True and rpm > 142:                  # rpm must be greater than 142 rpm
        Vout = (5*(rpm - 142))/(speedRange - 142)     # formulas for going from rpm to Vout are found in Motor Controller Instructions (5.1.4)
        print(Vout)
        GPIO.output(MEpin,GPIO.HIGH)                  # motor enabled
        if direction == 1:
            GPIO.output(MDpin,GPIO.LOW)               # motor clockwise turn
        elif direction == 2:
            GPIO.output(MDpin,GPIO.HIGH)              # motor counter-clockwise turn

        writeVoltage(Vout)                            # motor rpm set

    else:
        GPIO.output(MEpin,GPIO.LOW)                   # motor disable
	
def runCommand(motorRPM, directionVar, timeVar):
    print('Executing Command')
    setSolenoidValve(1) #GPIO.HIGH
    time.sleep(1)
    setMotor(True, directionVar, motorRPM)
    time.sleep(timeVar)
    setMotor(False, None, None) # Motor off
    setSolenoidValve(0) #GPIO.LOW
    time.sleep(2)

def changeBuoyancy(percent):
    #0 is 0 buoyancy, the robot will sink
    #1 is full buoyancy, the robot will rise

    currentBuoyancy = readBuoyancy()
    #I don't know if we will have fine enough control to get better than this
    if abs(percent - currentBuoyancy) > .3:
                if percent > currentBuoyancy:
                        #forward
                        GPIO.output(MDpin,GPIO.HIGH)
                else:
                        #backward
                        GPIO.output(MDpin,GPIO.LOW)
                #SValve = 1 open
                GPIO.output(SVpin,GPIO.HIGH)

                #MEnable = 1
                GPIO.output(MEpin,GPIO.HIGH)

                while abs(percent - currentBuoyancy) > .15:
                        currentBuoyancy = readBuoyancy()

                #MEnable = 0
                GPIO.output(MEpin,GPIO.LOW)
                #MDirection = 0
                GPIO.output(MDpin,GPIO.HIGH)
                #SValve = 0
                GPIO.output(SVpin,GPIO.HIGH)

def exit_cleanup():
        GPIO.cleanup(MEpin) # Motor Enable pin 17
        GPIO.cleanup(MDpin) # Motor Direction pin 18
        GPIO.cleanup(SVpin) # Solenoid Valve pin 22
        print("\n\nCleaning up pins\n\n")

def getStatusInfo():
    
    
    global serversocket
    
    msg = []
    
    serversocket.settimeout(5.0)
    
    # get local machine name
    host = (ip)
    port = 9000

    # bind to the port
    serversocket.bind((host, port))                                  

    # queue up to 5 requests
    serversocket.listen(4)

    msg.append("S")
    try:
        bus.read_byte(DAC_addr)
        msg.append("1")
    except:
        msg.append("0")

    try:
        bus.read_byte(ADC_addr)
        msg.append("1")
    except:
        msg.append("0")

    
    # establish a connection
    print( host)
    clientsocket = None
    #while(clientsocket == None):
    try:
            clientsocket,addr = serversocket.accept()
    except KeyboardInterrupt:
            exit_cleanup()
        
            #break
        #except:
          #  continue
    except socket.timeout as e:
        return
        
    with clientsocket:
        print("Got a connection from %s" % str(addr))

        msg.append("1")
        msg.append("1")
        message = ''.join(msg)
                
        clientsocket.send(message.encode('ascii'))
            
        clientsocket.close()
        


def collectData(pressure):
        global ptime
        global pdata
        if(time.clock() - ptime >= 1.0):
                ptime = time.clock()
                pdata.append((ptime,pressure))
        
def connect():
    global serversocket
    msg = []

    # queue up to 5 requests
    serversocket.listen(5)
    
    try:
        clientsocket,addr = serversocket.accept()
    except socket.timeout as e:
        return

    with clientsocket:
        print("Got a connection from %s" % str(addr))
       

        message = pickle.dumps([10,0,4,3,4,3,2,4,2,2,4,3,2,4])
        print(message)
        clientsocket.send(message)
        
        clientsocket.close()

def checkCommand():
    global serversocket

    serversocket.listen(5)
    
    try:
        clientsocket,addr = serversocket.accept()
    except socket.timeout as e:
        return

    with clientsocket:
        print("Received control command.")
        initialData = clientsocket.recv(1024)
        motorRPM, directionV, durationV = struct.unpack('iii', initialData)
        print("RPM: " + motorRPM + " Direction: " + directionV + " Duration: " + durationV)
        runCommand(motorRPM, directionV, durationV)
        clientsocket.close()

    #program starts
try:
    ADC_addr = 0x48
    DAC_addr = 0x60

    # Mapping of data/sample rate to config register values for ADS1015 (faster).
    programmable_gain_map = {6144: 0x0000, 4096: 0x0200, 2048: 0x0400, 1024: 0x0600, 512: 0x0800, 256: 0x0A00}
    channel_map = {0: 0x4000, 1: 0x5000, 2: 0x6000, 3: 0x7000} #map for channel
    samples_per_second_map = {128: 0x0000, 250: 0x0020, 490: 0x0040, 920: 0x0060, 1600: 0x0080, 2400: 0x00A0, 3300: 0x00C0} #sampling rate

    bus = SMBus(1)


    GPIO.setmode(GPIO.BCM) #sets pin numbering mode


    MEpin = 17 #off
    MDpin = 18 #forward
    SVpin = 22 #closed

    GPIO.setup(MEpin,GPIO.OUT,initial=GPIO.LOW) # Motor Enable pin MEpin
    GPIO.setup(MDpin,GPIO.OUT,initial=GPIO.LOW) # Motor Direction pin 18
    GPIO.setup(SVpin,GPIO.OUT,initial=GPIO.LOW) # Solenoid Valve pin 22

    #constants
    water_density = 1e3
    grav = 9.81

    ptime = time.clock()
    pdata = ["0"]

    maxPressure = .02 #Assuming PSI (~2m underwater)
    minPressure = .001

    ###################################
    ip = get('https://api.ipify.org').text
    print(ip)

    #status
    
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
    getStatusInfo()
    #except:
    #    print("DJFJ")

    #main loop
    while True:
            print("about to connect")
            #currentPressure = readPressure()
            collectData("12")
            connect()
            checkCommand()
            #if currentPressure > maxPressure:
                #changeBuoyancy(1) #Max Buoyancy

            #elif currentPressure < minPressure:
                #changeBuoyancy(0) #Min Buoyancy
except KeyboardInterrupt:
    exit_cleanup()


