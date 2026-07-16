#ifndef SPKIT_H
#define SPKIT_H

extern int sceKernelCreateThread(const char* name, void *entry, int initPriority, int stackSize, int attr, void *option);
extern int sceKernelStartThread(int thid, int arglen, void *argp);
extern int sceKernelExitDeleteThread(int status);
extern int sceKernelReferThreadStatus(int thid, void* info);
extern int sceKernelGetThreadId();
extern int sceKernelGetThreadStackFreeSize(int thid);
extern int sceKernelDelayThread(int delay);
extern void sceKernelExitGame(void);
extern void sceKernelDcacheWritebackInvalidateAll(void);
extern int sceKernelSelfStopUnloadModule(int unknown, int argsize, void* argp);
extern int sceKernelAllocPartitionMemory(int partitionid, const char* name, int type, int size, void* addr);
extern void *sceKernelGetBlockHeadAddr(int blockid);
extern int sceDisplaySetFrameBuf(void* topaddr, int bufferwidth, int pixelformat, int sync);
extern int sceDisplaySetMode(int mode, int width, int height);

extern void main(void);

#define u32         unsigned int
#define hwp         volatile u32*
#define hw(addr)    (*((hwp)(addr)))
#define sync()      asm volatile("sync")
#define DEBUG_ADDR  0x08a00000

#endif
