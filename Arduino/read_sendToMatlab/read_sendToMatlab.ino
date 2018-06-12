const int nSensors = 5;   // including zero

void setup() {
  Serial.begin(9600);
}

void loop() {
  for (int sensorPin = 0; sensorPin <= nSensors; sensorPin++) {
    float inputVoltage = analogRead(sensorPin);
    float voltage = ((5 * inputVoltage)/1024);
    if (sensorPin < nSensors) {
        Serial.print(voltage);
        Serial.print(",");
    }
    else{Serial.println(voltage);}
  }
}
