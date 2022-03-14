#define MC_ENABLE 0
#define MC_DIRECTION 1
#define SOLENOID 4
#define START_WAIT 60000 //60 seconds
unsigned long seconds = 1000;
unsigned long duration = 26;
void setup() {
  pinMode(SOLENOID, OUTPUT);
  pinMode(MC_ENABLE, OUTPUT);
  pinMode(MC_DIRECTION, OUTPUT);
  digitalWrite(SOLENOID, LOW);
  digitalWrite(MC_ENABLE, LOW);
  digitalWrite(MC_DIRECTION, LOW);
  
}

void loop() {
 delay(START_WAIT);
 contractBellows();
 //delay(9000);
 expandBellows();
 delay(START_WAIT / 2);
 expandBellows();
 //delay(9000);
 contractBellows();
 delay(START_WAIT);
}

void expandBellows() {
  digitalWrite(SOLENOID, HIGH);
  delay(2000);
  unsigned long starttime = millis();
  unsigned long endtime = starttime;
  digitalWrite(MC_DIRECTION, HIGH);
  digitalWrite(MC_ENABLE, HIGH);
  while((endtime - starttime) <= seconds*duration) {
    endtime = millis();
  }
  digitalWrite(MC_ENABLE, LOW);
  delay(2000);
  digitalWrite(SOLENOID, LOW);
}

void contractBellows() {
  digitalWrite(SOLENOID, HIGH);
  delay(2000);
  unsigned long starttime = millis();
  unsigned long endtime = starttime;
  digitalWrite(MC_DIRECTION, LOW);
  digitalWrite(MC_ENABLE, HIGH);
  while((endtime - starttime) <= seconds*duration) {
    endtime = millis();
  }
  digitalWrite(MC_ENABLE, LOW);
  delay(2000);
  digitalWrite(SOLENOID, LOW);
}
