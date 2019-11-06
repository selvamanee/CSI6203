#CSI6203:Scripting Languages
#Assignment:Sofware Base Solution
#Selvamanee Kinnoo ID:10431892

#!/bin/bash

#Connecting to the nasa website
echo "Connecting to nasa.gov..."

download() {

    echo -n "Type the URL of a file to download:"
    read URL
wget -nv -P "$URL" 

}
#To download images posted on the website using links
links=(
    "https://apod.nasa.gov/apod/image/1901/sombrero_spitzer_3000.jpg"
    "https://apod.nasa.gov/apod/image/1901/orionred_WISEantonucci_1824.jpg"
    "https://apod.nasa.gov/apod/image/1901/20190102UltimaThule-pr.png"
    "https://apod.nasa.gov/apod/image/1901/UT-blink_3d_a.gif"
    "https://apod.nasa.gov/apod/image/1901/Jan3yutu2CNSA.jpg"
)

names=(
    "file1.jpg"
    "file2.jpg"
    "file3.jpg"
    "file4.jpg"
    "file5.jpg"
) 

echo ${links[@]} ${names[@]} | xargs -P 8 -n 1 wget

{

#The date to download the image with its description
echo "date": "2019-08-03",
echo "explanation": "Peering from the shadows[...]",
echo "url": "https://apod.nasa.gov/apod/image/190803/Saturnlight[...]",
echo "media_type": "image",
echo "service_version": "v1",
echo "title": "Mimas in Saturnlight",
echo "url": "https://apod.nasa.gov/apod/image/190803/Saturnlight[...]"

curl https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY
    
}

wget `curl https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY | jq.url | tr -d '"'`
[...] 2019-08-03 - 'MimasPIA17213.jpg'

#To get the description of the images

curl -s http://apod.nasa.gov | \
tr '\n' ' ' | \
grep -oE '<div>.*<\/div>' | \
sed -e 's/<[^>]*>//g' -ne 's/  \+/\n/gp' | \
sed'/^[[:space:]]*$/d'

#To get all the images downloaded 

file=$(mktemp)
curl -s -o apod190803.html https://apod.nasa.gov
awk -F"=" '/.https.*\/apod.*title=.*/ {print $3}' ap190803.html | \
awk -F"\"" '{print $2}' | sort -url
rm "$file"





