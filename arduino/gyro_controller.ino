//
//    FILE: GY521_pitch_roll_yaw.ino
//  AUTHOR: Rob Tillaart
// VERSION: 0.1.0
// PURPOSE: demo PRY
//    DATE: 2020-08-06

#include "GY521.h"

GY521 sensor(0x68);

uint32_t counter = 0;

float pitch = 0;
float roll  = 0;
float yaw   = 0;

void setup()
{
  Serial.begin(115200);
  Serial.println(__FILE__);

  Wire.begin();
  pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
  delay(500);
  while (sensor.wakeup() == false)
  {
    Serial.print(millis());
    Serial.println("\tCould not connect to GY521");
    delay(1000);
  }
  sensor.setAccelSensitivity(2);  // 8g
  sensor.setGyroSensitivity(1);   // 500 degrees/s

  sensor.setThrottle();
  // set callibration values from calibration sketch.
  sensor.axe = 0;
  sensor.aye = 0;
  sensor.aze = 0;
  sensor.gxe = 0;
  sensor.gye = 0;
  sensor.gze = 0;
  pitch = sensor.getPitch();
  roll  = sensor.getRoll();
  yaw   = sensor.getYaw();

}

void loop()
{
  sensor.read();
  pitch = sensor.getPitch();
  roll  = sensor.getRoll();
  yaw   = sensor.getYaw();

  if (max(abs(pitch), abs(roll)) == abs(pitch)) {
	  if (pitch > 0) {
		  digitalWrite(10, LOW);
		  digitalWrite(11, LOW);
	  } else {
		  digitalWrite(10, LOW);
		  digitalWrite(11, HIGH);
	  }
  } else {
	  if (roll > 0) {
		  digitalWrite(10, HIGH);
		  digitalWrite(11, LOW);
	  } else {
		  digitalWrite(10, HIGH);
		  digitalWrite(11, HIGH);
	  }
  }



}

// -- END OF FILE --
