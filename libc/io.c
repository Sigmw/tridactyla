#include "io.h"

// buffer adress
#define BUFFER 0xb8000

void write(char* buf, int color) {
  char* mem = (char*)(BUFFER);
  while(*buf != 0) {
    *mem = *buf;
    mem++;
    buf++;
    *mem = color;
    mem++;
  }
}

void clear(void) {
  char* mem = (char*)(BUFFER);
  while(*mem != 0) {
    *mem = 0;
    mem++;
  }
}
