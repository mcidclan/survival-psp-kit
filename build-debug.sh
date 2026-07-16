#!/bin/bash
set -e

SRC_DIR=src
BUILD_DIR=debug
LINKER=$SRC_DIR/linker.ld

mkdir -p "$BUILD_DIR"

OBJS=()

echo "[1/4] Compiling .c files"
for f in "$SRC_DIR"/*.c; do
  name=$(basename "$f" .c)
  echo "  -> $f"
  mipsel-linux-gnu-gcc \
    -march=mips32 \
    -mabi=eabi \
    -mno-mips16 \
    -msoft-float \
    -mno-abicalls \
    -fno-pic \
    -G0 \
    -ffreestanding \
    -nostdlib \
    -I"$SRC_DIR" \
    -c "$f" \
    -o "$BUILD_DIR/$name.o"
  OBJS+=("$BUILD_DIR/$name.o")
done

echo "[2/4] Assembling .S files"
for f in "$SRC_DIR"/*.S; do
  name=$(basename "$f" .S)
  echo "  -> $f"
  mipsel-linux-gnu-as \
    -march=mips32 \
    -mabi=eabi \
    -msoft-float \
    -o "$BUILD_DIR/$name.o" \
    "$f"
  OBJS+=("$BUILD_DIR/$name.o")
done

echo "[3/4] Link ELF"
mipsel-linux-gnu-ld \
  -q \
  -T "$LINKER" \
  -zmax-page-size=128 \
  -o "$BUILD_DIR/debug.elf" \
  --emit-relocs \
  "${OBJS[@]}"

echo "Build ELF done"

psp-fixup-imports "$BUILD_DIR/debug.elf"
echo "fixup done"

psp-prxgen "$BUILD_DIR/debug.elf" "$BUILD_DIR/debug.prx"
echo "build prx done"

echo "[4/4] Packaging EBOOT.PBP"
mksfo "DEBUG" "$BUILD_DIR/PARAM.SFO"
pack-pbp "$BUILD_DIR/EBOOT.PBP" \
  "$BUILD_DIR/PARAM.SFO" \
  NULL \
  NULL \
  NULL \
  NULL \
  NULL \
  "$BUILD_DIR/debug.prx" \
  NULL

echo "eboot done"
