hexo generate
cp -R public/* deploy/yanglukuan.github.io
cd deploy/yanglukuan.github.io
git add .
git commit -m update
git push origin master