#define MC_ENABLE 0
#define MC_DIRECTION 1
#define SOLENOID 4
#define START_WAIT 30000 //30 seconds
unsigned long seconds = 1000;
unsigned long duration = 52;
void setup() {
  pinMode(SOLENOID, OUTPUT);
  pinMode(MC_ENABLE, OUTPUT);
  pinMode(MC_DIRECTION, OUTPUT);
  delay(5000);
  expandBellows();

}

void loop() {

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
