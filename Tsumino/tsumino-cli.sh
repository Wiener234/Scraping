#! /bin/sh

printf "Enter Number: " && read num
num=$(printf "$num" | cut -d\/ -f5)

dir="$HOME/.cache/Tsumino/$num"
mkdir -p $dir

pg=$(curl -s "https://www.tsumino.com/entry/$num" | sed -nE 's/.*Pages"> 2(.*) <\/div>.*/\1/p')

echo $pg
