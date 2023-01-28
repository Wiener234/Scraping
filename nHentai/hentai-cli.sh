#! /bin/bash

url="https://nhentai.net/g/83414/"

number="83414"

printf "Enter Number: " && read -r num || num=$* 
#printf "$num"
num=$(printf "$num" | cut -d / -f5)
printf "$num"

tmp=$(curl -s -o 'test.png' "https://nhentai.net/g/$num/1")

