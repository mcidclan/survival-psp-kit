#!/bin/bash
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" \
APP_NAME="spkit" \
MODULE_NAME="spkit-mod" \
DISPLAY_NAME="spkit, Debug" \
LIBS="spk" \
CFLAGS="-Os" \
"$SPKIT_ROOT/tools/build_eboot.sh"
