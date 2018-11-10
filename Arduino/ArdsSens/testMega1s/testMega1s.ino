const int nSensors = 1;   // including zero

void setup() {
  Serial.begin(9600);

}

void loop() {
  for (int sensorPin = 0; sensorPin <= nSensors; sensorPin++) {
    float inputVoltage = analogRead(sensorPin);
    float voltage = ((5.0 * inputVoltage)/1023.0);
    if (sensorPin < nSensors) {
        Serial.print(inputVoltage - 848);
        Serial.print(",");
    }
    else{Serial.println(inputVoltage - 217);}
  }
  // delay(100);
}
