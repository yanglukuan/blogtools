---
title: git多账号配置（Windows平台）
date: 2017-08-21 14:10:22
tags: git
categories: git
---

Git的配置相信大家都不陌生了，如果还不熟悉，不要着急，继续往下看就好了。今天主要看一下多账户的场景，顺便也复习一下Git的配置流程。  

---
## 什么情况下需要多账户的配置呢？
1.在公司一般大家都会配置公司的代码仓库的账户，用的账号一般是公司企业邮箱账号,比如`zhangsan@XXX.com`,一般的配置流程都是企业入职的时候给一个配置清单或者新手指导，员工自己按照指导去配置，无非也就是用git的SSH 命令生成密钥对，然后将公钥上传至管理平台，就可以很开心的写Bug了，哦 不对，写码。
但是某一天有这样一个场景，有时候自己也会写点代码，这些代码一般我们托管在GitHub等平台上，这个时候就无法使用公司的账号了，需要再配置一个GitHub的账号，比如`zhangsan@Gmail.com`这样的账户名字。
2.由于天朝独特的网络环境,你们懂得，有时候GitHub无法连接或者不稳定，这个时候需要有一个国内的代码托管平台，国内比如码云这样的平台也可以托管代码，速度比较稳定。这个时候就需要同时配置GitHub和码云两个账户。

## 具体配置
### 第一种情况
> 公司账户和GitHub账户（不同邮箱）

1.如果原来配置过一次，在用户目录下会有一个.ssh目录，里面存放着你默认第一次生成的秘钥对，`id_rsa`和`id_rsa.pub`,在此目录打开`Git bash` 输入命令 `ssh-keygen -C "zhangsan@Gmail.com" -t rsa ` 然后回车 这个时候需要注意，需要给生成的秘钥对命名，比如` id_rsa_github `，不然会以默认的名字`id_rsa`生成，从而覆盖掉原来生成的。然后回车两次，就可以成功生成秘钥。
2.生成秘钥成功后，把生成公钥上传到GitHub的秘钥管理平台上，然后最重要的步骤来了。
回到用户目录的.ssh目录，创建一个config文本文件，注意这个文件名字为config，没有后缀名，尝试过加上.config后缀，貌似不会被识别。这个配置文件就是告诉ssh多个账户下，每个账户对应的秘钥位置和Host位置。
config配置文件
```xml
# github 
Host github.com
HostName github.com
User zhangsan
IdentityFile ~/.ssh/id_rsa_github

# company
Host code.company.com
HostName code.company.com
User zhangsan
IdentityFile ~/.ssh/id_rsa

```
这样配置就结束了，打开`git bash` 输入命令测试一下
`ssh -T git@github.com `
成功的话会收到这样一段回复
`Hi zhangsan! You've successfully authenticated, but GitHub does not provide shell access.`
不成功的话，检查下上面的配置，或者使用`ssh -vT git@github.com`  查看下详细的错误信息。
3.有些网友的帖子会说如果配置了全局的Git用户名和邮箱，需要去掉，其实不去掉也是可以的。如果你先设置了公司的账户为全局配置，那么你克隆GitHub上的代码到本地后，只要在那个目录设置本地的用户名和邮箱，就可以了，因为本地的优先级要大于全局的设定，公司的代码目录则继续使用全局配置，一样的互不影响。

### 第二种情况
> GitHub和码云两个账号

1.不同邮箱
如果你同时拥有GitHub和码云两个账号，而又不是使用同一邮箱注册，其实也类似于上面这张情况，分别生成不同邮箱的秘钥，然后再`config`文件里配置相应的用户、秘钥位置和`Host`就可以了。
2.相同邮箱
如果是相同的邮箱，就不需要上面的配置，只要用这个邮箱生成一次秘钥，这个秘钥可以同时用在两个网站上，两个远程仓库都可以提交，因为`SSH`秘钥是用邮箱生成的，邮箱相同，则秘钥也相同，所以可以共用一个。

## 参考

http://www.jianshu.com/p/89cb26e5c3e8
https://gist.github.com/suziewong/4378434
http://noahsnail.com/2016/08/31/2016-9-1-Git%E5%A4%9A%E7%94%A8%E6%88%B7%E9%85%8D%E7%BD%AE/
https://steflerjiang.github.io/2016/12/16/git%E5%A4%9A%E8%B4%A6%E5%8F%B7%E9%85%8D%E7%BD%AE/
