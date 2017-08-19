hexo generate
cp -R public/* deploy/yanglukuan.github.io
cd deploy/yanglukuan.github.io
git pull
git add .
git commit -m update
git push origin master