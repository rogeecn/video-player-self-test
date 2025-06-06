# # 1. 生成视频
# -vf "scale=iw:ih:force_original_aspect_ratio=decrease,pad=ceil(iw/2)*2:ceil(ih/2)*2" \
ffmpeg -loop 1 -i cover.jpg \
    -vf "scale=1280:720:force_original_aspect_ratio=decrease" \
    -r 1 \
    -t 60 \
    -c:v libx264 \
    -pix_fmt yuv420p \
    -y video.mp4

# 同时添加两条音轨
ffmpeg -i video.mp4 \
    -i audio01.mp3 \
    -i audio02.mp3 \
    -map 0:v \
    -map 1:a \
    -map 2:a \
    -c:v copy \
    -c:a aac \
    -shortest \
    -metadata:s:a:0 title="Default" \
    -metadata:s:a:0 language=chi \
    -metadata:s:a:1 title="Second" \
    -metadata:s:a:1 language=eng \
    -disposition:a:0 default \
    -y final.mp4
