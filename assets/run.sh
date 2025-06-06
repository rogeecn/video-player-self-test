ffmpeg \
    -loop 1 -i cover.jpg \
    -i audio01.mp3 \
    -i audio02.mp3 \
    -s 1920x1080 \
    -c:v libx264 -tune stillimage \
    -c:a aac \
    -map 0:v -map 1:a -map 2:a \
    -disposition:a:0 default \
    -shortest \
    dual-tracks.mp4
