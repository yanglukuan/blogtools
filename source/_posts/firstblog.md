---
title: Hexo+GitHub Pages博客搭建
date: 2017-08-17 14:56:25
tags: Hexo
categories: Hexo
---

## 闲扯一会
由于要学习Java,最近读了不少书和博客,但是读下来发现了一些问题。比如，有些知识点看过很多次，每次看的时候都觉得似曾相识，却又记不起全貌。有些则是过目就忘，合上书本完全不记得书中所讲精要，甚是苦闷。这几日忽得夫人点拨，说是输出倒逼输出，意思就是充当别人的老师，然后逼自己学习更多的知识。这个道理大家自然都是懂得，只不过有时候做起来比较难以实践。一个是因为人都有惰性，好多事情都是停留在思想和嘴巴，付诸行动的少之又少。再者，也不太容易有机会充当别人的老师，而且本身我自己也不是那种好为人师的性格，倒不是清高装逼，也是怕误人子弟。
不过我们这个行业比较特殊，可以有很好的方式去做输出倒逼输入的事情，比如写博客。其实很早就注册了博客园，但是到现在也只是酱油和灌水，没有发过帖子。现在决定写博客，把自己的输入真正变成自己的东西，一方面在写的过程中梳理一下知识，另一方面也记录下自己解决过的问题、踩过的坑。博客前期打算以Step By Step的教程为主，主要为了熟悉markdown语法和Hexo博客的使用，后面会慢慢转向原理解析类和日常踩坑记录类。
**往者不可谏,来者犹可追。**

---

## 博客搭建
### GitHub Pages 设置
   Github Pages 是 Github 公司提供的免费的静态网站托管服务，用起来方便而且功能强大，不仅没有空间限制，还可以绑定自己的域名。在 https://pages.github.com/ 首页上可以看到很多用 Github Pages 托管的网站，很漂亮。另外很多非常著名的公司和项目也都用这种方式来搭建网站，如微软和 twitter 的网站，还有 谷歌的 Material Design 图标 网站。本博客就是利用Github Pages托管所建。开始创建自己的网站：  
   创建一个新的仓库  `yourname.github.io`，`yourname` 就是你github的用户名，不可以是其他字符，不然访问不到。
   只要把静态的网站文件上传到这个仓库，然后访问`https://yourname.github.io`，就可以看到自己的网站了。
### 安装Hexo
   Hexo出自台湾大学生tommy351之手，是一个基于Node.js的静态博客程序，其编译上百篇文字只需要几秒。hexo生成的静态网页可以直接放到GitHub Pages，BAE，SAE等平台上。
   所需环境
   Nodejs
   Git
   
1.首先安装好Nodejs和Git,Hexo安装过程中，有些文件是通过Git下载下来。
安装cnpm 由于天朝网路环境问题，所以最好安装cnpm 淘宝的镜像，下载比较快
`npm install -g cnpm --registry=https://registry.npm.taobao.org`
全局安装hexo
`cnpm install hexo-cli -g`
新建一个hexo/blog文件夹
进入到你的hexo/blog目录
打开git bash
`cnpm install hexo --save`
检查是否安装成功
`hexo -v`
初始化Hexo
`hexo init`
这里会创建一些文件
然后输入
`cnpm install`
这里要等一会，安装组件

2.然后就可以使用了
常用命令
`hexo new "Hello World"` 创建新页面
`hexo generate` 重新生成所有页面
`hexo server` 启动本地预览  预览地址 `http://localhost:4000`
 会看到一个默认主题的hexo网站。

 `hexo new` 命令会创建一个md格式的文件，就是我们写博客的文件，推荐使用markdownpad来写，支持各种markdown格式，
 其实在使用过程中无需使用此命令创建，只要在blog下的`\source\_posts`文件夹下直接新建md格式的文件就可以了。Hexo在生成博客的时候回自动识别这个目录下写所有md文件。

3.发布到GitHub
 找到blog目录下的`_config.yml`文件，加入以下节点
```deploy:
  type: git
  repo:
    github: <repository url>,[branch]```

执行命令
hexo d 就可以完成发布，发布成功后，就可以在`https://yourname.github.io`看到自己更新的内容了，由于CDN缓存的缘故，有时候更新后要过一会才可以看到最新的内容。


### 参考地址
   [https://linghucong.js.org/2016/04/15/2016-04-15-hexo-github-pages-blog/](https://linghucong.js.org/2016/04/15/2016-04-15-hexo-github-pages-blog/)
   http://gitbeijing.com/pages.html
   [http://www.jianshu.com/p/b8dd1e3e0255](http://www.jianshu.com/p/b8dd1e3e0255)
