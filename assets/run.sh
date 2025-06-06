# # 1. 生成视频
# -vf "scale=iw:ih:force_original_aspect_ratio=decrease,pad=ceil(iw/2)*2:ceil(ih/2)*2" \
ffmpeg -loop 1 -i cover.jpg \
    -vf "scale=1280:720:force_original_aspect_ratio=decrease" \
    -r 1 \
    -t 60 \
    -c:v libx264 \
    -pix_fmt yuv420p \
    -y video.mp4

# ## 2. 添加音频
# # 为 video.mp4 添加 audio01.mp3 作为默认音轨（命名为"默认"，语言为中文）
ffmpeg -i video.mp4 \
    -i audio01.mp3 \
    -map 0:v -map 1:a \
    -c:v copy \
    -c:a aac \
    -shortest \
    -metadata:s:a:0 title="默认" \
    -metadata:s:a:0 language=chi \
    -disposition:a:0 default \
    -y output_with_audio.mp4

## 3. 添加第二音轨
# 为 output_with_audio.mp4 添加第二条音轨 audio02.mp3（双音轨独立可切换）
ffmpeg -i output_with_audio.mp4 \
    -i audio02.mp3 \
    -map 0:v \
    -map 0:a:0 \
    -map 1:a:0 \
    -c:v copy \
    -c:a aac \
    -shortest \
    -metadata:s:a:0 title="默认" \
    -metadata:s:a:0 language=chi \
    -metadata:s:a:1 title="第二音轨" \
    -metadata:s:a:1 language=eng \
    -disposition:a:0 default \
    -y final.mp4
