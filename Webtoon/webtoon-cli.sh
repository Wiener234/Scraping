#! /bin/bash


#curl --header 'Referer: https://www.webtoons.com/' -o 'test.jpg' 'https://webtoon-phinf.pstatic.net/20220304_137/1646385131817lY3H6_JPEG/16463851318043643290.jpg?type=q90'
agent="Mozilla/5.0 (X11; Linux x86_64; rv:99.0) Gecko/20100101 Firefox/99.0"

url="https://www.webtoons.com/de/romance/leveling-up-my-husband-to-the-max/ep29/viewer?title_no=3643&episode_no=29"


#                                                          "ageGatePass=true;needCCPA=true;needCOPPA=true;needGDPR=false;latCOPPA=false;lnmaCOPPA=false"
curl -v --header 'Referer: https://www.webtoons.com/' -b "needCCPA=true;needCOPPA=true;needGDPR=false;pagGDPR:false;rstagGDPR_DE:false;timezoneOffset:+2;locale:en" -A "$agent" -o 'test.txt' 'https://www.webtoons.com/de/romance/leveling-up-my-husband-to-the-max/ep29/viewer?title_no=3643&episode_no=29'

# chapter_image_urls=($(
#     curl -A "$agent" "$url" |
#     sed '/viewer_img _img_viewer_area/,$p' |
#     sed '/day_info _readComplete/q;p' |
#     awk 'BEGIN{RS="\" alt="; FS="src\""}NF>1{print $NF}' 
# ))

printf "$chapter_image_urls"


# i=0

# 		for image_src in "${chapter_image_urls[@]}"; do
# 			((i=i + 1))

# 			# Download image in the background
# 			curl \
# 				--silent \
# 				--create-dirs \
# 				--header 'Referer: https://www.webtoons.com/' \
# 				--output "${i}.jpg" \
# 				"${image_src}" &
# 		done