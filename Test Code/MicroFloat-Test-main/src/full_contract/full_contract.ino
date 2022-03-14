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
  contractBellows();

}

void loop() {


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
