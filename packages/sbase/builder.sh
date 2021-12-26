set -e

for f in $(cd $src; find . -type f); do
	install -D "$src/$f" "$f"
done

make
make install "DESTDIR=$out" "PREFIX="
