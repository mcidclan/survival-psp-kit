#ifndef THREAD_MAN_FOR_USER_H
#define THREAD_MAN_FOR_USER_H

extern int sceKernelCreateThread(const char* name, void *entry, int initPriority, int stackSize, int attr, void *option);
extern int sceKernelStartThread(int thid, int arglen, void *argp);
extern int sceKernelExitDeleteThread(int status);
extern int sceKernelReferThreadStatus(int thid, void* info);
extern int sceKernelGetThreadId();
extern int sceKernelGetThreadStackFreeSize(int thid);
extern int sceKernelDelayThread(int delay);

#endif
