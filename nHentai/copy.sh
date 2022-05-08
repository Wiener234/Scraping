#!/bin/sh

agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"
[ -z "$*" ] && printf "enter(paste) number or link:" && read -r num || num=$*
num=$(printf "$num" | cut -d\/ -f5)
dir="$HOME/.cache/$num"
mkdir -p $dir
trap "rm -rf $dir;exit 0" INT HUP
printf "\033[1;34mFetching doujin.."
tmp=$(curl -A "$agent" -s "https://nhentai.net/g/$num/1/" | sed -nE 's_.*galleries/(.*)/1.* *class="num-pages">(.*)</span><.*_\1 \2_p')
pg=$(printf "$tmp" | cut -d" " -f2)
id=$(printf "$tmp" | cut -d" " -f1)
[ -z "$pg" ] && printf "\33[2K\r\033[1;31mDoujin not found!!\033[0m" && exit 0
printf "\33[2K\r\033[1;34m pages : $pg\n\033[1;33mdownloading pages>>\n"
for i in $(seq $pg);do
    i_t=$(printf "%03d" $i)
    sleep .1
        curl -A "$agent" -s "https://i.nhentai.net/galleries/$id/$i.jpg" -o "$dir/$i_t" && printf "\33[2K\r\033[1;32m $i ✓ (pgs left : %s)\033[0m" "$((pg - i))" && grep -q 404 "$dir/$i_t" && curl -s "https://i.nhentai.net/galleries/$id/$i.png" > "$dir/$i_t" && printf "\33[2K\r\033[1;32m $i ✓✓ (pgs left : %s)\033[0m" "$((pg - i))" &
done
wait
printf "\n\033[1;36mconcatenating pages to pdf"
convert "$dir/*" "$num.pdf" && printf "\n\033[1;35msaved pdf as $num.pdf...enjoy 😏😏\033[0m" 
rm -rf $dir
zathura $num.pdf