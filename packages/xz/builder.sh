set -e

bzip2 -cd "$src" | tar -x
cd "$name"
./configure --p "$out"
make
make install
