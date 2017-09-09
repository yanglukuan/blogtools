echo -e "\033[40;33m hexo clean................. \033[0m"
hexo clean
echo -e "\033[40;33m hexo generate................. \033[0m"
hexo generate
echo -e "\033[40;33m start localhost server............. \033[0m"
start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://localhost:4000/
hexo server --drafts