#!/bin/sh

agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"
[ -z "$*" ] && printf "enter(paste) number or link:" && read -r num || num=$*
num=$(printf "$num" | cut -d\/ -f5)
dir="$HOME/.cache/$num"
mkdir -p $dir
trap "rm -rf $dir;exit 0" INT HUP
printf "\033[1;34mFetching doujin.."
pg=$(curl -A "$agent" -s "https://nhentai.net/g/$num/1/" | sed -nE 's/.*pages">(.*)<\/span><.*/\1/p')
[ -z "$pg" ] && printf "\33[2K\r\033[1;31mDoujin not found!!\033[0m" && exit 0
printf "\33[2K\r\033[1;34m pages : $pg\n\033[1;33mdownloading pages>>\n"
for i in $(seq $pg);do
    i_t=$(printf "%03d" $i)
    curl -A "$agent" -s "$(curl -A "$agent" -s "https://nhentai.net/g/$num/$i/" | sed -nE 's/.*<img src="([^"]*)".*/\1/p')" -o "$dir/$i_t" && printf "\33[2K\r\033[1;32m $i ✓ (pgs left : %s)" "$((pg - i))" || printf "\033[1;31m $i ❌\n" &
    sleep .2
done
wait
printf "\n\033[1;36mconcatenating pages to pdf"
convert "$dir/*" "$num.pdf" 2>/dev/null && printf "\33[2K\r\033[1;35msaved pdf as $num.pdf...enjoy 😏😏\033[0m\n" || printf "\33[2K\r\033[1;31msomething went wrong.. check the pdf if pages are missing\033[0m\n"
rm -rf $dir