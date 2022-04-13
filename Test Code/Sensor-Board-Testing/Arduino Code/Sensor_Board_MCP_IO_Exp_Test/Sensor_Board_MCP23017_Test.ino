// Wire Master Reader
// by Nicholas Zambetti <http://www.zambetti.com>

// Demonstrates use of the Wire library
// Reads data from an I2C/TWI slave device
// Refer to the "Wire Slave Sender" example for use with this

// Created 29 March 2006

// This example code is in the public domain.


#include <Wire.h>

void setup() {
  Wire.begin();        // join i2c bus (address optional for master)
  Serial.begin(9600);  // start serial for output
}

void setup_MCP23017(){

  //Initalize port A
  Wire.beginTransmission(0x20); // device address if A0 A1 and A2 are grounded
  Wire.write(0x00); // IODIRA register (direction, input (1) or output (0)  
  Wire.write(0xFF); // set all of port A to inputs
  //End the transmission                                                    
  Wire.endTransmission(); 
                                              
  //Initalize port A
  Wire.beginTransmission(0x20); // device address if A0 A1 and A2 are grounded
  Wire.write(0x01); // IODIRB register (direction, input (1) or output (0)  
  Wire.write(0xFF); // set all of port B to inputs
  //End the transmission                                                    
  Wire.endTransmission(); 
                                              
}


void loop() {
  setup_MCP23017();
  Wire.beginTransmission(0x20);  
  Wire.write(0x13); //set memory pointer to GPIOA base address
  Wire.endTransmission();
  Wire.requestFrom(0x20, 1);    // request 6 bytes from slave device #8
  while (Wire.available()<1);  // slave may send less than requested
  Serial.print("data:   ");
  Serial.println(Wire.read(), BIN);

  Serial.println("done ============================= ");
  delay(2000);
}
