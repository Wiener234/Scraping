#! /bin/bash

#agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"

while [[ "${1}" ]];do
    case "${1}" in
        -C|--clear-cache)
            rm -rf $HOME/.cache/nHentai/*
            exit 0
            ;;
    esac
done




printf "Enter Number: " && read num
num=$(printf "$num" | cut -d\/ -f5)

dir="$HOME/.cache/nHentai/$num"
mkdir -p $dir


pg=$(curl -s "https://nhentai.net/g/$num/1/" | sed -nE 's#.*class="num-pages">(.*)</span><.*#\1#p')


for i in $(seq $pg);do
    i_t=$(printf "%03d" $i)

    curl -s -A "$agent" -o "$dir/$i_t" "$(curl -s "https://nhentai.net/g/$num/$i/" | sed -nE 's#.*<img src="([^"]*)".*#\1#p')" && printf "\33[2K\r\033[1;32m $i ✓ (pgs left : %s)" "$((pg - i))"
    sleep .2
done

#convert "$dir/*" "$num.pdf"

for i in $(seq $pg);do 
    i_t=$(printf "%03d" $i)
    convert "$dir/$i_t" "$dir/$i_t.jpg" && printf "\33[2K\r\033[1;32m convert: $i ✓ (pgs left : %s)" "$((pg - i))"
    rm "$dir/$i_t"
done

sxiv $dir/* &
