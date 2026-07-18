#ifndef SCE_DISPLAY_H
#define SCE_DISPLAY_H

extern int sceDisplaySetFrameBuf(void* topaddr, int bufferwidth, int pixelformat, int sync);
extern int sceDisplaySetMode(int mode, int width, int height);

#endif

