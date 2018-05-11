hostAddress=$(/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2| cut -d' ' -f1)
echo Using Host: $(echo -e "$hostAddress" | tr -d '[:space:]')
bundler exec jekyll serve --host=$(echo -e "$hostAddress" | tr -d '[:space:]')