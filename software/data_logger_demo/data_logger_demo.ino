// INCLUDES

#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <DPEng_BMX160.h>
#include <SerialFlash.h>
#include <SPI.h>
#include <stdlib.h>
#include "mbed.h"
#include <Adafruit_HTS221.h>

// DEFINES

#define PWM_PIN               3
#define PWM_FREQUENCY         22500
#define BIT_RATE              5

#define MOSI              D11
#define MISO              D12
#define SCK               D13
#define CS                D10

#define MODE_SELECT_PIN   D7

#define ERASE false

// initialize sensor constructs and PWM pin
DPEng_BMX160 BMX160sensor = DPEng_BMX160(0x160A, 0x160B, 0x160C);

MS5837 MS5837sensor;

Adafruit_HTS221 hts;

mbed::PwmOut pwmPin( digitalPinToPinName( PWM_PIN ) );

// variables/functions to help with flash

uint32_t fileSize = !;
uint32_t filePosition = 0;

char filename[32];

char flashBuffer[256]; // buffer of data to be written to flash with next function call

void updateFilename();
void setRegister(uint32_t index, uint32_t value); // set value of non-volative backup register
uint32_t getRegister(uint32_t index);
bool eraseFileContent(const char* filename); // erase file on flash to regain storage

// GLOBAL SENSOR DATA CONSTRUCTS

struct BMX160data {
  float x;
  float y;
  float z;
} accel, gyro, magneto;

struct MS5837data {
  float pressure; // mbar
  float temperature; // deg C
  float depth; // m
  float altitude; // m above sea level
} temppres;

struct HTS221data {
  float temperature;
  float humidity;
} temphum;

void setup(void)
{
  // BEGIN ALL SENSORS, PINS, AND FLASH
  
  pwmPin.period( 1.0 / PWM_FREQUENCY ); // set pwm pin frequency
  pinMode(MODE_SELECT_PIN, INPUT);
  
  Serial.begin(115200);
  while (!Serial) {
    delay(100);
  }

  while (!BMX160sensor.begin(BMX160_ACCELRANGE_4G, GYRO_RANGE_250DPS)) {
    delay(100);
  }

  while (!MS5837sensor.init()) {
    delay(100);
  }
  
  MS5837sensor.setModel(MS5837::MS5837_30BA);
  MS5837sensor.setFluidDensity(997);

  while (!hts.begin_I2C()) {
    delay(100);
  }
  
  hts.setDataRate(HTS221_RATE_1_HZ);

  // setup for backup registers
  #ifdef HAL_PWR_MODULE_ENABLED
    /* Allow access to Backup domain */
    HAL_PWR_EnableBkUpAccess();
  #endif
  #ifdef __HAL_RCC_BKP_CLK_ENABLE
    /* Enable BKP CLK for backup registers */
    __HAL_RCC_BKP_CLK_ENABLE();
  #endif

  // configure SPI
  SPI.setMOSI(MOSI);
  SPI.setMISO(MISO);
  SPI.setSCLK(SCK);
  SerialFlash.begin(CS);

  // erase the flash (optional)
  if (ERASE) {
    Serial.println("Erasing Flash..."); SerialFlash.eraseAll();
    // reset the backup register value to 0 (optional)
    setRegister(1, 0);
  }

  while (!SerialFlash.ready()) {
    delay(100);
  }

  // create new file to which data will be written
  
  filename = updateFilename(filename);
  if (SerialFlash.exists(filename)) {
    // SerialFlash.remove(filename);  // It doesn't reclaim the space, but it does let you create a new file with the same name.
    eraseFileContent(filename);
  }
  
  if (!SerialFlash.createErasable(filename, fileSize)) {
    Serial.println("Flash is full!");
    exit(1);
  }
}

// BMX160 Functions
void readBMX160() { // (BMX160data& accel, BMX160data& gyro, BMX160data& magneto)
  sensors_event_t aevent, gevent, mevent;

  // get a sensor event
  BMX160sensor.getEvent(&aevent, &gevent, &mevent);

  // form of output
  accel.x = aevent.acceleration.x; // m/s^2
  accel.y = aevent.acceleration.y;
  accel.z = aevent.acceleration.z;
  gyro.x = gevent.gyro.x; // g
  gyro.y = gevent.gyro.y;
  gyro.z = gevent.gyro.z;
  magneto.x = mevent.magnetic.x; // uT
  magneto.y = mevent.magnetic.y;
  magneto.z = mevent.magnetic.z;
}

// control for activity states
void sleepBMX160() {
  BMX160sensor.standby(true);
}

void wakeBMX160() {
  BMX160sensor.standby(false);
}

// HTS221 Functions
void readHTS221() {
  sensors_event_t temp;
  sensors_event_t humidity;
  hts.getEvent(&humidity, &temp);
  temphum.temperature = temp; // degrees C
  temphum.humidity = humidity; // % rH (relative humidity)
}

void sleepHTS221() {
  // PD bit 7 for Ctrl Reg 1 set to zero
  hts.setActive(false);
}

void wakeupHTS221() {
  // PD bit 7 for Ctrl Reg 1 set to one
  hts.setActive(true);
}

// MS5837-30BA Functions
void readMS5837() {
  // form of output
  temppres.pressure = MS5837sensor.pressure(); // mbar
  temppres.temperature = MS5837sensor.temperature(); // deg C
  temppres.depth = MS5837sensor.depth(); // m
  temppres.altitude = MS5837sensor.altitude(); // m above sea level
}

// Flash Functions
bool writeBufferToFile(SerialFlashFile file) {
  if (file) {
    file.seek(filePosition);
    filePosition += 256;
    file.write(flashBuffer, 256);
    file.close();
    return true;
  } else {
    Serial.println("Error opening file");
    return false;
  }
}

bool eraseFileContent(const char* filename) {
  SerialFlashFile file;
  file = SerialFlash.open(filename);
  if (file) {
    file.erase();
    return true;
  } else {
    Serial.println("Error opening file");
    return false;
  }
}

bool writeBMX160ToFile(const char* filename) {
  SerialFlashFile file;
  file = SerialFlash.open(filename);
  if (file) {
    // convert sensor readings from float to char array (C-string)
    char accel_x[16];
    dtostrf(accel.x, 4, 3, accel_x);
    char accel_y[16];
    dtostrf(accel.y, 4, 3, accel_y);
    char accel_z[16];
    dtostrf(accel.z, 4, 3, accel_z);

    char gyro_x[16];
    dtostrf(gyro.x, 4, 3, gyro_x);
    char gyro_y[16];
    dtostrf(gyro.y, 4, 3, gyro_y);
    char gyro_z[16];
    dtostrf(gyro.z, 4, 3, gyro_z);

    char magneto_x[16];
    dtostrf(magneto.x, 4, 3, magneto_x);
    char magneto_y[16];
    dtostrf(magneto.y, 4, 3, magneto_y);
    char magneto_z[16];
    dtostrf(magneto.z, 4, 3, magneto_z);

    // create message
    strcpy(flashBuffer, "accel_x: "); // use strcpy instead of strcat to clear the buffer
    strcat(flashBuffer, accel_x);
    strcat(flashBuffer, ", accel_y: ");
    strcat(flashBuffer, accel_y);
    strcat(flashBuffer, ", accel_z: ");
    strcat(flashBuffer, accel_z);
    strcat(flashBuffer, "\n");
    strcat(flashBuffer, "gyro_x: ");
    strcat(flashBuffer, gyro_x);
    strcat(flashBuffer, ", gyro_y: ");
    strcat(flashBuffer, gyro_y);
    strcat(flashBuffer, ", gyro_z: ");
    strcat(flashBuffer, gyro_z);
    strcat(flashBuffer, "\n");
    strcat(flashBuffer, "magneto_x: ");
    strcat(flashBuffer, magneto_x);
    strcat(flashBuffer, ", magneto_y: ");
    strcat(flashBuffer, magneto_y);
    strcat(flashBuffer, ", magneto_z: ");
    strcat(flashBuffer, magneto_z);
    strcat(flashBuffer, "\n");

    // write buffer
    return writeBufferToFile(file);
  } else {
    return false;
  }
}

bool writeMS5837ToFile(const char* filename) {
  SerialFlashFile file;
  file = SerialFlash.open(filename);
  if (file) {
  char pressure[16];
  char temperature[16];
  char depth[16];
  char altitude[16];

  dtostrf(temppres.pressure, 4, 3, pressure);
  dtostrf(temppres.temperature, 4, 3, temperature);
  dtostrf(temppres.depth, 4, 3, depth);
  dtostrf(temppres.altitude, 4, 3, altitude);

  strcpy(flashBuffer, "pressure: ");
  strcat(flashBuffer, pressure);
  strcat(flashBuffer, ", temperature: ");
  strcat(flashBuffer, temperature);
  strcat(flashBuffer, ", depth: ");
  strcat(flashBuffer, depth);
  strcat(flashBuffer, ", altitude: ");
  strcat(flashBuffer, altitude);
  strcat(flashBuffer, "\n");

  // write buffer
  return writeBufferToFile(file);
  } else {
    return false;
  }
}

bool writeHTS221ToFile(const char* filename) {
  SerialFlashFile file;
  file = SerialFlash.open(filename);
  if (file) {
  char internal_temp[16];
  char humidity[16];

  dtostrf(temphum.humidity, 4, 3, humidity);
  dtostrf(temphum.temperature, 4, 3, internal_temp);

  strcpy(flashBuffer, "humidity: ");
  strcat(flashBuffer, humidity);
  strcat(flashBuffer, ", internal temperature: ");
  strcat(flashBuffer, internal_temp);
  strcat(flashBuffer, "\n");

  // write buffer
  return writeBufferToFile(file);
  } else {
    return false;
  }
}

void printFromFlash(const char* filename) {
  SerialFlashFile file;
  file = SerialFlash.open(filename);
  if (file) {
    char buffer[256];
    for (int i = 0; i < file.size() / 256; i++) {
      file.seek(i * 256);
      file.read(buffer, 256);
      if (buffer[0] == 255) {
        // Serial.println("End of data found");
        break;
      }
      Serial.println(buffer);
    }
    file.close();
  } else {
    Serial.println("Error opening file");
  }
}

void readAllFiles() {
  uint32_t filesize;
  char readFilename[32];
  SerialFlash.opendir();
  while (SerialFlash.readdir(readFilename, sizeof(readFilename), filesize)) {
    Serial.print("File: ");
    Serial.println(readFilename);
    Serial.println("-----");
    printFromFlash(readFilename);
    Serial.println("-----");
  }
  Serial.println("All files read from Flash");
}

// backup register functions
void setRegister(uint32_t index, uint32_t value) {
  LL_RTC_BAK_SetRegister(RTC, index, value);
}

uint32_t getRegister(uint32_t index) {
  return LL_RTC_BAK_GetRegister(RTC, index);
}

const char* updateFilename(const char* filename) {
  strcpy(filename, "file");
  uint32_t reg = getRegister(1);
  char r[16];
  itoa(reg, r, 10);
  strcat(filename, r);
  strcat(filename, ".txt");
  // increment filename
  setRegister(1, reg + 1);
  return filename;
}

// Example: Just read/write the BMX160 data, other sensors work equivalently
void loop(void)
{
  wakeBMX160(); // incorporates a slight delay for the sensors to wake up
  readBMX160();
  if (!writeBMX160ToFile(filename)) {
    Serial.println("Writing data failed!");
  }
  // write one sensor reading to the file
  sleepBMX160(); // sleep the sensors

  if (digitalRead(MODE_SELECT_PIN) == HIGH) { // check for data recovery mode
    // Serial.println("Entering recovery mode...");
    while (!(Serial.available() > 0)) { // wait for a command to be entered
      delay(10);
    }
    char c = Serial.read(); // read in one character as the command
    // flush the receive buffer
    while (Serial.available()) {
      Serial.read();
    }
    if (c == 'r') {
      // Serial.println("Printing all files...");
      readAllFiles();
    } else if (c == 'e') {
      // Serial.println("Erasing Flash...");
      SerialFlash.eraseAll();
      setRegister(1, 0);
      // Serial.println("Erasing Done");
    }
    // Serial.println("Exiting recovery mode...");
    delay(2000);
  }
}
