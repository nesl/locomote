#include "mbed.h"

#define PWM_PIN               4
#define PWM_FREQUENCY         10000

mbed::PwmOut pwmPin( digitalPinToPinName( PWM_PIN ) );

void setup()
{
  pwmPin.period( 1.0 / PWM_FREQUENCY );
}


void loop()
{
  pwmPin.write(0.5f);
  delay(1000);
  pwmPin.write(0.0f);
  delay(500);
}
