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

void setup_mpu_6050_registers(){

  //Activate the MPU-6050
  
  //Start communicating with the MPU-6050
  Wire.beginTransmission(0x68); 
  //Send the requested starting register                                       
  Wire.write(0x6B);  
  //Set the requested starting register                                                  
  Wire.write(0x00);
  //End the transmission                                                    
  Wire.endTransmission(); 
                                              
  //Configure the accelerometer (+/-8g)
  
  //Start communicating with the MPU-6050
  Wire.beginTransmission(0x68); 
  //Send the requested starting register                                       
  Wire.write(0x1C);   
  //Set the requested starting register                                                 
  Wire.write(0x10); 
  //End the transmission                                                   
  Wire.endTransmission(); 
                                              
  //Configure the gyro (500dps full scale)
  
  //Start communicating with the MPU-6050
  Wire.beginTransmission(0x68);
  //Send the requested starting register                                        
  Wire.write(0x1B);
  //Set the requested starting register                                                    
  Wire.write(0x08); 
  //End the transmission                                                  
  Wire.endTransmission(); 
                                              
}


void loop() {
  //setup_mpu_6050_registers();
  Wire.beginTransmission(0x49);  
  Wire.write(0x90);
  Wire.endTransmission();
  Wire.requestFrom(0x49, 14);    // request 6 bytes from slave device #8

  while (Wire.available()<14);  // slave may send less than requested
  Serial.print("acc x:   ");
  Serial.println(Wire.read()<<8|Wire.read());
  Serial.print("acc y:   ");
  Serial.println(Wire.read()<<8|Wire.read());
  Serial.print("acc z:   ");
  Serial.println(Wire.read()<<8|Wire.read());
  Serial.print("temp:   ");
  Serial.println(Wire.read()<<8|Wire.read());
  Serial.print("gyro x:   ");
  Serial.println(Wire.read()<<8|Wire.read());
  Serial.print("gyro y:   ");
  Serial.println(Wire.read()<<8|Wire.read());
  Serial.print("gyro z:   ");
  Serial.println(Wire.read()<<8|Wire.read());

  Serial.println("done ============================= ");
  delay(2000);
}
