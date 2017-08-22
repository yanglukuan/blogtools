hexo clean
hexo generate
cp -R public/* deploy/yanglukuan.github.io
cd deploy/yanglukuan.github.io
git add .
git pull
git commit -m update
git push origin master
cmd