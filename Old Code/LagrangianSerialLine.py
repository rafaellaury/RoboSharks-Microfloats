# TODO: update to use correct method of toggling GPIO pins
#       add correct pins for i2c and update remaining code to use it for all analog signals
#
#  I2C over pins 2 and 3
#    12Bit ADC
#      Hall Effect Sensors 1 and 2
#      Pressure Sensor analog input
#    DAC
#      Motor Speed Analog Out


import RPi.GPIO as GPIO
from smbus2 import SMBus
import time
import socket
from requests import get
import pickle

def tabletopStartup(n):                # This fuction is only useful for the tabletop testing and has values hard coded
    rpm = 0
    for i in range(n):
        rpm += 500
        print("RPM = ", rpm)
        setSolenoidValve(GPIO.HIGH)
        time.sleep(2)
        setMotor(True, "CW", rpm)      # Motor running CW at multiples of 500 rpm up to n * 500 rpm
        time.sleep(5)
        setMotor(False, None, None)    # Turn off motor
        setSolenoidValve(GPIO.LOW)
        time.sleep(5)
        print("Reversing directions")
        setSolenoidValve(GPIO.HIGH)
        time.sleep(2)
        setMotor(True, "CCW", rpm)     # Motor running CCW at multiples of 500 rpm up to n * 500 rpm
        time.sleep(5)
        setMotor(False, None, None)    # Turn off motor
        setSolenoidValve(GPIO.LOW)
        time.sleep(5)   
        print("RPM = ", rpm, " finished") 
        
def customTest():
    mode = int(input("Press 1 for one direction, 2 for one direction and then reverse: "))
    runtime = int(input("Runtime: "))
    speed = int(input("RPM: "))
    direction = input("CW or CCW: ")

    if direction == "CW":
        reverse_dir = 'CCW'
    else:
        reverse_dir = 'CW'
    
    if mode == 1:
        setSolenoidValve(GPIO.HIGH)
        time.sleep(1)
        setMotor(True, direction, speed)      # Motor on
        time.sleep(runtime)                   # Motor runtime
        setMotor(False, None, None)           # Motor off
        setSolenoidValve(GPIO.LOW)
        time.sleep(2)
        print("Custom Test Complete!")
    else:
        setSolenoidValve(GPIO.HIGH)
        time.sleep(1)
        setMotor(True, direction, speed)      # Motor on
        time.sleep(runtime)                   # Motor runtime
        setMotor(False, None, None)           # Motor off
        setSolenoidValve(GPIO.LOW)
        time.sleep(2)
        print("Reversing direction")

        setSolenoidValve(GPIO.HIGH)
        time.sleep(1)
        setMotor(True, reverse_dir, speed)      # Motor on
        time.sleep(runtime)                   # Motor runtime
        setMotor(False, None, None)           # Motor off
        setSolenoidValve(GPIO.LOW)
        time.sleep(2)
        print("Custom Test Complete!")


def bleeding(sec):
    # Sends out air bubbles from the system by spinning in one direction continuously
    print("Starting bleeding in one direction")
    setSolenoidValve(GPIO.HIGH)
    time.sleep(1)
    setMotor(True, "CW", rpm=1000)      # Motor running CW at 1000 rpm
    time.sleep(sec)
    setMotor(False, None, None)        # Turn off motor
    setSolenoidValve(GPIO.LOW)
    time.sleep(2)
    print("Finished")
        
def writeVoltage(Vout):
    value  = int((4096*Vout)/5.0)
    if(value > 4095):
        value = 4095
    elif(value < 0): 
        value = 0 
    reg_data = [(value >> 4) & 0xFF, ((value & 0xF) << 4) & 0xFF]
    #reg_data = [int(value/16), (value % 16) << 4]
    
    bus.write_i2c_block_data(DAC_addr,0x60,reg_data)


def setMotor(enable, direction, rpm):                 
    speedRange = 11285                                # this if for a 7 pole pair motor with DIP Switch S7 on
    if enable == True and rpm > 142:                  # rpm must be greater than 142 rpm
        Vout = (5*(rpm - 142))/(speedRange - 142)     # formulas for going from rpm to Vout are found in Motor Controller Instructions (5.1.4)
        print(Vout)
        GPIO.output(MEpin,GPIO.HIGH)                  # motor enabled
        if direction == "CW":
            GPIO.output(MDpin,GPIO.LOW)               # motor clockwise turn
        else:
            GPIO.output(MDpin,GPIO.HIGH)              # motor counter-clockwise turn

        writeVoltage(Vout)                            # motor rpm set

    else:
        GPIO.output(MEpin,GPIO.LOW)                   # motor disable
    

def setSolenoidValve(val):
    # Retract if val == 0, extend if val == 1
    if (val == 1 or val == GPIO.HIGH):
        GPIO.output(SVpin, GPIO.HIGH)
    elif (val == 0 or val == GPIO.LOW):
        GPIO.output(SVpin, GPIO.LOW)

    
def exit_cleanup():
    GPIO.cleanup(MEpin) # Motor Enable pin 17
    GPIO.cleanup(MDpin) # Motor Direction pin 18
    GPIO.cleanup(SVpin) # Solenoid Valve pin 22
    print("\n\nCleaning up pins\n\n")

    
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

    GPIO.setup(MEpin,GPIO.OUT,initial=GPIO.LOW) # Motor Enable pin 17
    GPIO.setup(MDpin,GPIO.OUT,initial=GPIO.LOW) # Motor Direction pin 18
    GPIO.setup(SVpin,GPIO.OUT,initial=GPIO.LOW) # Solenoid Valve pin 22

    # bleeding(25)
    # tabletopStartup(4)                 # n = 3, sample test loop number
    customTest() # placeholder till we get a decided sequence

except KeyboardInterrupt:
    #GPIO.output(MEpin,GPIO.LOW) # Disables motor on keyboard interrupt / don't have to call setMotor again
    #GPIO.output(MDpin,GPIO.LOW) # Motor Direction pin 18
    #GPIO.output(SVpin,GPIO.LOW) # Solenoid Valve pin 22
    #print("Did you just press C? Did you just kill me?")
    setMotor(False, None, None)
    print("setMotor executed")
    # exit_cleanup()

#____________________________________________________________________________________________________________________________


#constants
#     water_density = 1e3
#     grav = 9.81

#     ptime = time.clock()
#     pdata = ["0"]

#     maxPressure = .02 #Assuming PSI (~2m underwater)
#     minPressure = .001


# def changeBuoyancy(percent):
#     #0 is 0 buoyancy, the robot will sink
#     #1 is full buoyancy, the robot will rise

#     currentBuoyancy = readBuoyancy()
#     #I don't know if we will have fine enough control to get better than this
#     if abs(percent - currentBuoyancy) > .3:
#         if percent > currentBuoyancy:
#             # forward
#             GPIO.output(MDpin,GPIO.HIGH)
#         else:
#             # backward
#             GPIO.output(MDpin,GPIO.LOW)
#         #SValve = 1 open
#         GPIO.output(SVpin,GPIO.HIGH)

#         #MEnable = 1
#         GPIO.output(MEpin,GPIO.HIGH)

#         while abs(percent - currentBuoyancy) > .15:
#             currentBuoyancy = readBuoyancy()

#         #MEnable = 0
#         GPIO.output(MEpin,GPIO.LOW)
#         #MDirection = 0
#         GPIO.output(MDpin,GPIO.HIGH)
#         #SValve = 0
#         GPIO.output(SVpin,GPIO.HIGH)
    

# def readPressure():
# 	#Read from Pressure Sensor    
# 	pres = read_adc(2)
 
# 	#currently assuming this returns the voltage so we need to divide it by the max voltage of the system (5V)
# 	return pres/5.0

# def readBuoyancy():
# 	# read position of piston from hall sensors and return % buoyancy
# 	b1 = read_adc(Channel = 1)
# 	b2 = read_adc(Channel = 0)

# 	return abs(b1-2.5) * 1/2.5

# def read_adc(Channel):
#     try:
#         config = 0x0003 | 0x8000 | 0x0100 | programmable_gain_map[6144]  | channel_map[Channel] | samples_per_second_map[1600]
                        
#         #transmit config info
#         bus.write_i2c_block_data(ADC_addr, 1, [(config >> 8) & 0xFF, config & 0xFF]) #write to register 1

#         time.sleep(1/1600 + .001) #wait 1 sample

#         #read value
#         chlist = bus.read_i2c_block_data(ADC_addr, 0, 2) #read 2 bytes from register 0
#         voltage =  ((chlist[0] << 4) | chlist[1])  * 6144 / 2048.0 / 1000.0

#         num = (200/.5)*voltage - 1000
#         if(abs(num)<75 or int(num) == 209 or int(num) == 190 or int(num) == 113 or  int(num) == 132 or int(num) == 94):
#             num = 0.0
#         return num
#     except:
#         return 0.0

# def getDepth(preassure):
# 	#P/(pg) = depth
# 	depth = preassure/(water_density*grav)
# 	return depth


