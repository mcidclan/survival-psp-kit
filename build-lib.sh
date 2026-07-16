#!/bin/bash
set -e

SRC_DIR=src
BUILD_DIR=lib
OBJ_DIR=$BUILD_DIR/obj
LIB_DIR=$BUILD_DIR/lib
INC_DIR=$BUILD_DIR/include
LIB_NAME=libspk.a

mkdir -p "$OBJ_DIR" "$LIB_DIR" "$INC_DIR"

OBJS=()

echo "[1/4] Compiling .c files"
for f in "$SRC_DIR"/*.c; do
  name=$(basename "$f" .c)
  echo "  -> $f"
  mipsel-linux-gnu-gcc \
    -march=mips2 \
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
    -o "$OBJ_DIR/$name.o"
  OBJS+=("$OBJ_DIR/$name.o")
done

echo "[2/4] Assembling .S files"
for f in "$SRC_DIR"/*.S; do
  name=$(basename "$f" .S)
  echo "  -> $f"
  mipsel-linux-gnu-as \
    -march=mips2 \
    -mabi=eabi \
    -msoft-float \
    -I"$SRC_DIR" \
    -o "$OBJ_DIR/$name.o" \
    "$f"
  OBJS+=("$OBJ_DIR/$name.o")
done

echo "[3/4] Creating archive $LIB_NAME"
mipsel-linux-gnu-ar rcs "$LIB_DIR/$LIB_NAME" "${OBJS[@]}"
mipsel-linux-gnu-ranlib "$LIB_DIR/$LIB_NAME"

echo "[4/4] Publishing headers"
cp "$SRC_DIR"/*.h "$INC_DIR"/
cp "$SRC_DIR"/*.inc "$INC_DIR"/

echo "Lib build done"
echo "  archive : $LIB_DIR/$LIB_NAME"
echo "  headers : $INC_DIR"

