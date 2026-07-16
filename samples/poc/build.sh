#!/bin/bash
set -e

APP_NAME="poc"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ROOT_DIR=$(cd "$SCRIPT_DIR/../.." && pwd)

BUILD_DIR=$SCRIPT_DIR/build

LIB_DIR=$ROOT_DIR/lib/lib
INC_DIR=$ROOT_DIR/lib/include
LIB_LINK_NAME=spk

LINKER=$ROOT_DIR/src/linker.ld

mkdir -p "$BUILD_DIR"

OBJS=()

echo "[1/5] Compiling .c files"
for f in "$SCRIPT_DIR"/*.c; do
    name=$(basename "$f" .c)
    echo "  -> $(realpath --relative-to="$ROOT_DIR" "$f")"
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
        -I"$INC_DIR" \
        -c "$f" \
        -o "$BUILD_DIR/$name.o"
    OBJS+=("$BUILD_DIR/$name.o")
done

echo "[2/5] Assembling .S files"
shopt -s nullglob
for f in "$SCRIPT_DIR"/*.S; do
    name=$(basename "$f" .S)
    echo "  -> $(realpath --relative-to="$ROOT_DIR" "$f")"
    mipsel-linux-gnu-as \
        -march=mips2 \
        -mabi=eabi \
        -msoft-float \
        -I"$INC_DIR" \
        -o "$BUILD_DIR/$name.o" \
        "$f"
    OBJS+=("$BUILD_DIR/$name.o")
done
shopt -u nullglob

echo "[3/5] Link ELF against lib$LIB_LINK_NAME.a"
mipsel-linux-gnu-ld \
    -q \
    -T "$LINKER" \
    -zmax-page-size=128 \
    -u module_start \
    -o "$BUILD_DIR/$APP_NAME.elf" \
    --emit-relocs \
    "${OBJS[@]}" \
    -L"$LIB_DIR" -l"$LIB_LINK_NAME"
echo "  -> $(realpath --relative-to="$ROOT_DIR" "$BUILD_DIR/$APP_NAME.elf")"

psp-fixup-imports "$BUILD_DIR/$APP_NAME.elf"
echo "fixup done"

psp-prxgen "$BUILD_DIR/$APP_NAME.elf" "$BUILD_DIR/$APP_NAME.prx"
echo "  -> $(realpath --relative-to="$ROOT_DIR" "$BUILD_DIR/$APP_NAME.prx")"

echo "[4/5] Packaging EBOOT.PBP"
mksfo "${APP_NAME^^}" "$BUILD_DIR/PARAM.SFO" > /dev/null
pack-pbp "$BUILD_DIR/EBOOT.PBP" \
    "$BUILD_DIR/PARAM.SFO" \
    NULL \
    NULL \
    NULL \
    NULL \
    NULL \
    "$BUILD_DIR/$APP_NAME.prx" \
    NULL > /dev/null
echo "  -> $(realpath --relative-to="$ROOT_DIR" "$BUILD_DIR/EBOOT.PBP")"

echo "[5/5] eboot done"
