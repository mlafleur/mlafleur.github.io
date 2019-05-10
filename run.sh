hostAddress=$(/sbin/ifconfig eth1 | awk -F ' *|:' '/inet /{print $3}')
echo Using Host: $(echo -e "$hostAddress" | tr -d '[:space:]')
bundler exec jekyll serve --host=$(echo -e "$hostAddress" | tr -d '[:space:]')