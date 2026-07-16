#include "main.h"

static const char msg[] = "Survive all PSP Leaks";

void main(void) {
  
  debugByte(msg);
  
  const unsigned int vram = 0x44000000;
  sceDisplaySetMode(0, 480, 272);
  sceDisplaySetFrameBuf((void*)vram, 512, 3, 1);
  
  drawLine(
    (void*)vram, 512,
    192, 136, 128,
    0xff0000ff
  );
  
  // 10 sec, just to check the debug messages
  sceKernelDelayThread(10000000);
  sceKernelExitGame();
}
