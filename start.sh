#!/bin/bash

git clone https://github.com/volarjs/services volar-services
git clone https://github.com/volarjs/volar.js volar-volar.js
git clone https://github.com/kabiaa/atom-ide-volar vue-atom
git clone https://github.com/yaegassy/coc-volar vue-coc
git clone https://github.com/xiaoxin-sky/lapce-vue vue-lapce
git clone https://github.com/Kingwl/monaco-volar vue-monaco
git clone https://github.com/sublimelsp/LSP-volar vue-sublime
git clone https://github.com/volarjs/volar.js vue-vine
git clone https://github.com/vuejs/language-tools vue-volar
# git clone https://github.com/johnsoncodehk/volar-dev vue-volar-dev # not public

node fetchAvatars.js

gource --output-custom-log volar-services.txt volar-services
gource --output-custom-log volar-volar.js.txt volar-volar.js
gource --output-custom-log vue-atom.txt vue-atom
gource --output-custom-log vue-coc.txt vue-coc
gource --output-custom-log vue-lapce.txt vue-lapce
gource --output-custom-log vue-monaco.txt vue-monaco
gource --output-custom-log vue-sublime.txt vue-sublime
gource --output-custom-log vue-vine.txt vue-vine
gource --output-custom-log vue-volar.txt vue-volar
# gource --output-custom-log vue-volar-dev.txt vue-volar-dev # not public

sed -i '' 's/|\//|Services\//g' volar-services.txt
sed -i '' 's/|\//|Volar.js\//g' volar-volar.js.txt
sed -i '' 's/|\//|Atom\//g' vue-atom.txt
sed -i '' 's/|\//|coc.nvim\//g' vue-coc.txt
sed -i '' 's/|\//|Lapce\//g' vue-lapce.txt
sed -i '' 's/|\//|Monaco\//g' vue-monaco.txt
sed -i '' 's/|\//|Sublime\//g' vue-sublime.txt
sed -i '' 's/|\//|Vine\//g' vue-vine.txt
sed -i '' 's/|\//|Volar\//g' vue-volar.txt
# sed -i '' 's/|\//|Volar\//g' vue-volar-dev.js.txt

cat volar-services.txt volar-volar.js.txt vue-atom.txt vue-coc.txt vue-lapce.txt vue-monaco.txt vue-sublime.txt vue-vine.txt vue-volar.txt vue-volar-dev.txt| sort -n > combined.txt

sed -i '' 's/|johnsoncodehk|/|Johnson Chu|/g' combined.txt
sed -i '' 's/|翠 \/ green|/|sapphi-red|/g' combined.txt
sed -i '' 's/|三咲智子|/|Kevin Deng 三咲智子|/g' combined.txt
sed -i '' 's/|三咲智子 Kevin Deng|/|Kevin Deng 三咲智子|/g' combined.txt

gource combined.txt -s 0.1 --auto-skip-seconds 1 --multi-sampling --stop-at-end --highlight-users --highlight-colour FF0000 --title "Volar.js" --user-image-dir avatars --key --file-idle-time 0 --max-file-lag 0.1 --max-files 0 --max-user-speed 500 --max-user-speed 500 --max-files 0 --max-file-lag 0.1 --file-idle-time 0 --bloom-multiplier 0.5 --bloom-intensity 0.5 --hide filenames,dirnames --font-size 24