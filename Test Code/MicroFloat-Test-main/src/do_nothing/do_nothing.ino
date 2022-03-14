#define MC_ENABLE 0
#define MC_DIRECTION 1
#define SOLENOID 4

void setup() {
  pinMode(SOLENOID, OUTPUT);
  pinMode(MC_ENABLE, OUTPUT);
  pinMode(MC_DIRECTION, OUTPUT);
  digitalWrite(SOLENOID, LOW);
  digitalWrite(MC_ENABLE, LOW);
  digitalWrite(MC_DIRECTION, LOW);


}
void loop() {

}
