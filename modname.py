import sys

PLACEHOLDER = b"SPKIT_DEFAULT_MODULE_NAME"
FIELD_SIZE = 27
MAX_NAME_LEN = 26

def patch(path, name):
  if len(name) > MAX_NAME_LEN:
    raise ValueError(f"Name too long ({len(name)} chars, max {MAX_NAME_LEN}).")

  data = bytearray(open(path, "rb").read())
  offset = data.find(PLACEHOLDER)
  if offset == -1:
    raise ValueError("Placeholder not found.")

  data[offset:offset + FIELD_SIZE] = name.encode("ascii").ljust(FIELD_SIZE, b"\0")
  open(path, "wb").write(data)
  print(f"Patched at offset {offset}: {name!r}")

patch(sys.argv[1], sys.argv[2])
