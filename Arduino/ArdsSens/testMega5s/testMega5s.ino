const int nSensors = 4;   // including zero

void setup() {
  Serial.begin(115200);
}

void loop() {
  for (int sensorPin = 0; sensorPin <= nSensors; sensorPin++){
    float inputVoltage = analogRead(sensorPin);
    float voltage = ((5.0 * inputVoltage)/1023.0);
    if (sensorPin < nSensors) {
        Serial.print(voltage);
        Serial.print(",");
    }
    else{Serial.println(voltage);}
  }
}
