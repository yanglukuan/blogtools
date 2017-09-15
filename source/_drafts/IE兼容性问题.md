---
title: IE兼容性问题
tags:
---


## 识别ie浏览器

``` javaScript

function isIE(){
        var b = document.createElement('b')
        b.innerHTML = '<!--[if IE]><i></i><![endif]-->'
        return (b.getElementsByTagName('i').length === 1 || ("ActiveXObject" in window));
       //前半部分ie6-9  后半部分Ie10 IE11
    }

```


## new date 问题


## 使用propertychange 并且blur之后需要取消事件 否则会堆栈溢出

## focus 焦点问题
