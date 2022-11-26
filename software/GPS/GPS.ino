#include <Adafruit_GPS.h>
#include <Wire.h>
#include <Adafruit_INA219.h>

Adafruit_INA219 ina219;

Adafruit_GPS GPS(&Wire);

#define GPSECHO true

int timer = 0;

void setup() {
  Serial.begin(115200);
  while (!Serial) {
    delay(100);
  }
  Wire.begin();
  uint32_t currentFrequency;
  if (!ina219.begin()) {
    Serial.println("Failed to find INA219 chip");
    while (1) { delay(10); }
  }
  ina219.setCalibration_16V_400mA();
  
  GPS.begin(0x10);

  GPS.sendCommand(PMTK_SET_NMEA_OUTPUT_RMCGGA);
  GPS.sendCommand(PMTK_SET_NMEA_UPDATE_1HZ);
  GPS.sendCommand(PGCMD_ANTENNA);

  delay(1000);
}

void readPA1010D() {
  GPS.read();
  if (GPS.newNMEAreceived()) {
    Serial.println(GPS.lastNMEA());
    Serial.print("Fix: "); Serial.println(GPS.fix);
    GPS.parse(GPS.lastNMEA());
  }
}

void startPA1010D() {
  do {
    readPA1010D();
    // Serial.println("Waiting for fix...");
    // delay(50);
  } while (!GPS.fix);
  Serial.println("Fix acquired");
}

void sleepPA1010D() {
  GPS.standby();
}

void wakeupPA1010D() {
  GPS.wakeup();
}

void readPower() {
  float power_mW = 0;
  power_mW = ina219.getPower_mW();
  Serial.print("Power:         "); Serial.print(power_mW); Serial.println(" mW");
}


void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("Testing Start");
  
  wakeupPA1010D();
  
  // Test 1: Cold Start (getting a fix aka Acquisition)
  Serial.println("Cold start test");
  readPower();
  startPA1010D();
  readPower();
  delay(5000);

  Serial.println("Warm start test");
  // sleepPA1010D();
  // delay(2000);
  // wakeupPA1010D();
  delay(2000);
  readPower();
  startPA1010D();
  readPower();
  delay(5000);
  
  
  // Test 2: Active (maintaining a fix aka Tracking)
  Serial.println("Active test");
  readPower();
  readPA1010D();
  readPower();
  Serial.println("---");
  delay(500);
  readPower();
  readPA1010D();
  readPower();
  Serial.println("---");
  delay(500);
  readPower();
  readPA1010D();
  readPower();
  Serial.println("---");
  delay(500);
  readPower();
  readPA1010D();
  readPower();
  Serial.println("---");
  delay(500);
  
  
  // Test 4: Sleep
  Serial.println("Sleep test");
  sleepPA1010D();
  delay(2000);
  readPower();
  delay(2000);
  readPower();
  delay(2000);
  
  Serial.println("Testing done");
}
