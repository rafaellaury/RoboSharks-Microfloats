#include <Wire.h>

int data = 0;
int reg = 0;

void setup() {
  Wire.begin();        // join i2c bus (address optional for master)
  Serial.begin(9600);  // start serial for output
  
}

void loop() {
  while(reg <= 16) {
    Wire.beginTransmission(0x49);  
    Wire.write(reg<<3); //RHR (read holding register) 
    Wire.endTransmission();
      
    Wire.requestFrom(0x49, 1);    //
    if (Wire.available()) {
      data = Wire.read();
      Serial.print("Register: ");
      Serial.println(reg);
      Serial.print("Data:   ");
      Serial.println(data);
    }
    Serial.println();
    reg++;
  }
  Serial.println("done ============================= ");
  delay(1000);
  reg = 0;
}
