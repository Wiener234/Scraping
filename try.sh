#! /bin/bash

agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"



printf "Enter Number: " && read num
num=$(printf "$num" | cut -d\/ -f5)

dir="$HOME/.cache/nHentai/$num"
mkdir -p $dir


tmp=$(curl -A "$agent" -s "https://nhentai.net/g/$num/1/" | sed -nE 's#.*class="num-pages">(.*)</span><.* .*galleries/(.*)/1.*" width.*#\1 \2#p')
pg=$(printf "$tmp" | cut -d" " -f1)
id=$(printf "$tmp" | cut -d" " -f2)
printf "$pg"


for i in $(seq $pg);do
    i_t=$(printf "%03d" $i)
    printf "$i\n"
    test="$(curl -s "https://nhentai.net/g/$num/$i/" | sed -nE 's#.*<img src="([^"]*)".*#\1#p')"
    printf "$test"
    sleep .2
done