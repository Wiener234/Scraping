#! /bin/bash

cache_dir="/home/nils/scripts/bash/scraping/cache"

#agent="Mozilla/5.0 (X11; Linux x86_64; rv:99.0) Gecko/20100101 Firefox/99.0"

#url="https://raw.githubusercontent.com/Blatzar/scraping-tutorial/master/README.md"
#update="$(curl -A "$agent" -s "https://v16.mkklcdnv6tempv5.com/img/tab_16/03/72/00/la988557/chapter_1/2-o.jpg")"

#curl -s --create-dirs --header 'Referer: https://readmanganato.com/' -o 'test.jpg' "https://v16.mkklcdnv6tempv5.com/img/tab_16/03/72/00/la988557/chapter_1/2-o.jpg"

#printf '%s\n' "$update" 


# chapter_image_urls=($(
# 			curl --silent "https://readmanganato.com/manga-la988557/chapter-1" | # Scrape URL
# 			sed --silent '/container-chapter-reader/,$p' | # Delete text before 'container-chapter-reader'
# 			sed --silent '/max-height: 380px/q;p' | # Delete text after 'max-height: 380px'
# 			awk 'BEGIN{RS="\" alt="; FS="src=\""}NF>1{print $NF}' # Get image URLs from HTML 'src' attribute
            
#         ))


#printf "$chapter_image_urls"

# for image_src in "${chapter_image_urls[@]}"; do
# 			((i=i + 1))

# 			# Download image in the background
# 			curl \
# 				--silent \
# 				--create-dirs \
# 				--header 'Referer: https://readmanganato.com/' \
# 				--output "$(printf '%03d.jpg' $i)" \
# 				"${image_src}" &
# 		done


    image_dir="$/chapter_1"
	pdf_dir="${cache_dir}/${mod_manga_title}/chapter_1.pdf"
	
	clear
 
	if [[ ! -f "${pdf_dir}" ]]; then # If PDF file does not exist
		printf "Fetching chapter ..."

		IFS=$'\n'

		chapter_image_urls=($(
			curl --silent "https://readmanganato.com/manga-la988557/chapter-1" | # Scrape URL
			sed --silent '/container-chapter-reader/,$p' | # Delete text before 'container-chapter-reader'
			sed --silent '/max-height: 380px/q;p' | # Delete text after 'max-height: 380px'
			awk 'BEGIN{RS="\" alt="; FS="src=\""}NF>1{print $NF}' # Get image URLs from HTML 'src' attribute
		))

		printf "\n"
		printf "Downloading images..."

		i=0

		for image_src in "${chapter_image_urls[@]}"; do
			((i=i + 1))

			# Download image in the background
			curl \
				--silent \
				--create-dirs \
				--header 'Referer: https://readmanganato.com/' \
				--output "$(printf '%03d.jpg' $i)" \
				"${image_src}" &
		done

		wait # Wait until all images are downloaded
	fi