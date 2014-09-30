
url="http://pallini.di.uniroma1.it/nauty25r9.tar.gz"
curl -o /tmp/nauty.tar.gz "$url"

rm -rf src/nauty/*
tar xzf /tmp/nauty.tar.gz -C src/nauty/ --strip-components 1

## We have no permission to distribute these
rm -f src/nauty/watercluster2.* src/nauty/planarity.* src/nauty/planarg.* \
   src/nauty/config{ure,.guess,.sub}

sources=$(cd src; ls nauty/*.c |
	      grep -v '^nauty/sorttemplates.c$'  |
	      grep -v '^nauty/splay.c$')

objects=$(echo "$sources" | sed 's/.c$/.o/')

echo OBJECTS=$objects > src/Makevars

for s in $sources nauty/rng.h nauty/naurng.h; do
    sed -i "" 's/main[(]/static main(/' src/"$s"
    sed -i "" 's/writeny[(]/static writeny(/' src/"$s"
    sed -i "" 's/writeg6x[(]/static writeg6x(/' src/"$s"
    sed -i "" 's/writes6x[(]/static writes6x(/' src/"$s"
    sed -i "" 's/writenauty[(]/static writenauty(/' src/"$s"
    sed -i "" 's/writeautom[(]/static writeautom(/' src/"$s"
    sed -i "" 's/testmax[(]/static testmax(/' src/"$s"
    sed -i "" 's/ran_init[(]long/static ran_init(long/' src/"$s"
done
