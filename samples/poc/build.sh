#!/bin/bash
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" \
APP_NAME="poc" \
MODULE_NAME="spkit-poc-mod" \
DISPLAY_NAME="spkit, PoC" \
LIBS="spk" \
CFLAGS="-Os" \
"$SPKIT_ROOT/tools/build_eboot.sh"
