#ifndef SPKIT_H
#define SPKIT_H

#include <LoadExecForUser.h>
#include <ModuleMgrForUser.h>
#include <sceDisplay.h>
#include <SysMemUserForUser.h>
#include <ThreadManForUser.h>
#include <UtilsForUser.h>

extern void main(void);

#define u32         unsigned int
#define hwp         volatile u32*
#define hw(addr)    (*((hwp)(addr)))
#define sync()      asm volatile("sync")
#define DEBUG_ADDR  0x08a00000

#endif
