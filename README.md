```sh
gource combined.txt --caption-file caption.txt --user-image-dir avatars --dir-name-depth 1 --seconds-per-day 0.15 --disable-input --hide filenames --caption-offset -100 --caption-size 30 -f -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 gource.mp4
```
