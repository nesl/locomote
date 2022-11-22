#include "mbed.h"

#define PWM_PIN               4
#define PWM_FREQUENCY         22500
#define BIT_RATE              2

mbed::PwmOut pwmPin( digitalPinToPinName( PWM_PIN ) );

void sendSymbol(char c);
void sendString(const char* str);

void setup()
{
  pwmPin.period( 1.0 / PWM_FREQUENCY );
}

void loop()
{
  // sendSymbol('t');
  sendString("0.1834", 6);
}

void send0() {
  pwmPin.write(0.0f); // send a 0
}

void send1() {
  pwmPin.write(0.5f); // send a 1
}

void sendSymbol(char c) {
  if (c == 't') { // test symbol
    send1();
      delay(1000 / BIT_RATE);
    send1();
      delay(1000 / BIT_RATE);
    send0();
      delay(1000 / BIT_RATE);
    send0();
      delay(1000 / BIT_RATE);
    send1();
      delay(1000 / BIT_RATE);
    send0();
      delay(1000 / BIT_RATE);
    send1();
      delay(1000 / BIT_RATE);
    send0();
      delay(1000 / BIT_RATE);
  }
  switch (c) {
    // symbol set, basic block/binary encoding --> 4 bits per symbol
    case '0':
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
    break;
    case '1':
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
    break;
    case '2':
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
    break;
    case '3':
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
    break;
    case '4':
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
    break;
    case '5':
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
    break;
    case '6':
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
    break;
    case '7':
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
    break;
    case '8':
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
    break;
    case '9':
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
    break;
    case '.':
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
    break;
    case ',':
        send1();
          delay(1000 / BIT_RATE);
        send0();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
        send1();
          delay(1000 / BIT_RATE);
    break;
  }
}

void sendString(const char* str, int length) {
  for (int i = 0; i < length; i++) {
    sendSymbol(str[i]);
  }
}
