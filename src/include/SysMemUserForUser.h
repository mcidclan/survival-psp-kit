#ifndef SYS_MEM_USER_FOR_USER_H
#define SYS_MEM_USER_FOR_USER_H

extern int sceKernelAllocPartitionMemory(int partitionid, const char* name, int type, int size, void* addr);
extern void *sceKernelGetBlockHeadAddr(int blockid);

#endif

