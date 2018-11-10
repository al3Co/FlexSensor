
void setup() {
  Serial.begin(115200);
}
void loop() {
  Serial.print(analogRead(0));
  Serial.print(",");
  Serial.print(analogRead(1));
  Serial.print(",");
  Serial.print(analogRead(2));
  Serial.print(",");
  Serial.print(analogRead(3));
  Serial.print(",");
  Serial.print(analogRead(4));
  Serial.print(",");
  Serial.print(analogRead(8));
  Serial.print(",");
  Serial.print(analogRead(9));
  Serial.print(",");
  Serial.print(analogRead(10));
  Serial.print(",");
  Serial.println(analogRead(11));
}
