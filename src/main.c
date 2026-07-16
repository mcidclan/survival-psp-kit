#include "spkit.h"

static const char msg[] = "Survival PSP Kit";

__attribute__((weak, noinline, aligned(4)))
void main(void) {
  
  volatile char *debug = (volatile char*)DEBUG_ADDR;

  int i = 0;
  while (msg[i] != '\0') {
    debug[i] = (unsigned int)msg[i];
    i++;
  }
}

__attribute__((noinline, aligned(4), nomips16))
static int thread(int args, void *argp) {
  
  main();
  return 0;
}

int _start(int argc, void *argv) {

  int thid = sceKernelCreateThread("user_thread", (void*)thread, 0x20, 0x40000, 0, 0);
  if (thid >= 0) {
    sceKernelStartThread(thid, 0, 0);
  }
  return 0;
}

