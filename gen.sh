rm -rf hls

mkdir -p hls/video
ffmpeg -i assets/final.mp4 \
    -map 0:v:0 -map 0:a:0 \
    -c:v libx264 -c:a aac \
    -f hls \
    -hls_time 10 \
    -hls_flags single_file+split_by_time+append_list+independent_segments+discont_start \
    -hls_segment_filename hls/video/main.ts \
    hls/video/index.m3u8

mkdir -p hls/audio
ffmpeg -i assets/final.mp4 \
    -map 0:a:1 \
    -c:a aac -vn \
    -f hls \
    -hls_time 10 \
    -hls_flags single_file+split_by_time+append_list+independent_segments+discont_start \
    -hls_segment_filename hls/audio/main.ts \
    hls/audio/index.m3u8

cat >hls/variant.m3u8 <<EOF
#EXTM3U

#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="zh",NAME="主音轨",AUTOSELECT=YES,DEFAULT=YES,URI="video/index.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="zh",NAME="第二音轨",AUTOSELECT=NO,DEFAULT=NO,URI="audio/index.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=800000,CODECS="avc1.64001f,mp4a.40.2",AUDIO="audio"
video/index.m3u8
EOF
