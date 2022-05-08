#! /bin/bash

agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"

curl 'https://nhentai.net/' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:100.0) Gecko/20100101 Firefox/100.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: de,en-US;q=0.7,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'Connection: keep-alive' -H 'Cookie: cf_clearance=OjZDRGT5.yFz_2lEbGcn3wnUTbaCbMhEJeNZJye5iUQ-1652013268-0-150; csrftoken=ROHpVtLMJeZpWq9ii4jCdNhfTcKonDVStxdxHI2ka6SId2bpiBi4RHHdVNBOnEpH' -H 'Upgrade-Insecure-Requests: 1' -H 'Sec-Fetch-Dest: document' -H 'Sec-Fetch-Mode: navigate' -H 'Sec-Fetch-Site: cross-site' -H 'TE: trailers'

printf "Enter Number: " && read num
num=$(printf "$num" | cut -d\/ -f5)

dir="$HOME/.cache/nHentai/$num"
mkdir -p $dir


tmp=$(curl "https://nhentai.net/g/$num/1" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:100.0) Gecko/20100101 Firefox/100.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: de,en-US;q=0.7,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'Connection: keep-alive' -H 'Cookie: cf_clearance=OjZDRGT5.yFz_2lEbGcn3wnUTbaCbMhEJeNZJye5iUQ-1652013268-0-150; csrftoken=ROHpVtLMJeZpWq9ii4jCdNhfTcKonDVStxdxHI2ka6SId2bpiBi4RHHdVNBOnEpH' -H 'Upgrade-Insecure-Requests: 1' -H 'Sec-Fetch-Dest: document' -H 'Sec-Fetch-Mode: navigate' -H 'Sec-Fetch-Site: cross-site' -H 'TE: trailers' | sed -nE 's#.*class="num-pages">(.*)</span><.* .*galleries/(.*)/1.*" width.*#\1 \2#p')
pg=$(printf "$tmp" | cut -d" " -f1)
id=$(printf "$tmp" | cut -d" " -f2)



for i in $(seq $pg);do
    i_t=$(printf "%03d" $i)

    curl -s -A "$agent" -o "$dir/$i_t" "$(curl -s "https://nhentai.net/g/$num/$i/" | sed -nE 's#.*<img src="([^"]*)".*#\1#p')" && printf "\33[2K\r\033[1;32m $i ✓ (pgs left : %s)" "$((pg - i))"
    sleep .1
done

#convert "$dir/*" "$num.pdf"

for i in $(seq $pg);do 
    i_t=$(printf "%03d" $i)
    convert "$dir/$i_t" "$dir/$i_t.jpg" && printf "\33[2K\r\033[1;32m convert: $i ✓ (pgs left : %s)" "$((pg - i))"
    rm "$dir/$i_t"
done

sxiv $dir/* &
wait