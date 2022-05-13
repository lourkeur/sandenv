set -e

xz -cd "$src" | tar -x
cd "$name"
./configure --p "$out"
make
make install
