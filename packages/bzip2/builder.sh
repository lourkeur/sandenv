set -e

gzip -cd "$src" | tar -x
cd "$name"
./configure --p "$out"
make
make install
