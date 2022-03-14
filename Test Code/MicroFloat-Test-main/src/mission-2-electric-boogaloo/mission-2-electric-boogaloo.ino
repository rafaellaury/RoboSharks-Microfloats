#define MC_ENABLE 0
#define MC_DIRECTION 1
#define SOLENOID 4
#define START_WAIT 2000 //2 seconds
unsigned long seconds = 1000;
unsigned long duration = 26;
void setup() {
  pinMode(SOLENOID, OUTPUT);
  pinMode(MC_ENABLE, OUTPUT);
  pinMode(MC_DIRECTION, OUTPUT);
}

void loop() {
 expandBellows();
 delay(START_WAIT);
 contractBellows();
}

void expandBellows() {
  digitalWrite(SOLENOID, HIGH);
  delay(START_WAIT);
  unsigned long starttime = millis();
  unsigned long endtime = starttime;
  digitalWrite(MC_DIRECTION, HIGH);
  digitalWrite(MC_ENABLE, HIGH);
  while((endtime - starttime) <= seconds*duration) {
    endtime = millis();
  }
  digitalWrite(MC_ENABLE, LOW);
  delay(START_WAIT);
  digitalWrite(SOLENOID, LOW);
}

void contractBellows() {
  digitalWrite(SOLENOID, HIGH);
  delay(START_WAIT);
  unsigned long starttime = millis();
  unsigned long endtime = starttime;
  digitalWrite(MC_DIRECTION, LOW);
  digitalWrite(MC_ENABLE, HIGH);
  while((endtime - starttime) <= seconds*duration) {
    endtime = millis();
  }
  digitalWrite(MC_ENABLE, LOW);
  delay(START_WAIT);
  digitalWrite(SOLENOID, LOW);
}
