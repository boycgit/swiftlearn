# swiftlearn

## 原因

我是一名前端，想学Swift；

从两年前就开始想学，直到现在才开始；但我想应该不会太迟；

学习最好的途径就是借鉴，创建该项目的思想来源于 [自学 iOS - 三十天三十个 Swift 项目](http://www.jianshu.com/p/52032bc4cbe4#) 

本次学习会比较详细记录自己学习的一点一滴，给想学习swift的人一点儿参考；因为自己对JS语言比较熟悉，因此行文过程中会或多或少会将这两种语言进行对比；

强烈建议在学习Swift工程之前阅读[官方指南](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#)，网上也有很多中文版；

## 目录

### 基础知识篇

有些语法比较重要，为了帮助记忆，我简单快速做了一些笔记：
 - [看懂闭包](./basic/closure.md)：快速理解闭包的语法
 - [全局函数](./basic/inner-fn.md)：包含了如何查找全局函数的tips
 - [错误处理](./basic/error-handle.md)：文章包含了ErrorType protocol、 guard、defer 等知识点
 - [Cocoa框架](./basic/cocoa.md)：初学者可能对Cocoa框架、Foundation框架不太清楚，收集了一些资料帮助理解
 - [自适应布局](./basic/adaptive.md)：详细介绍自适应布局，包含outlets、actions创建的方法
 - [理解storyboard](./basic/storyboard.md)：入门级介绍什么是storyboard，它由哪些部分组成等；

### IOS开发基础
 - [Touch事件及手势的处理](./dev-basic/touch.md)：移动端touch是整个交互的基础，所以要最先掌握；其中涉及 First Response 的用法
 - [用户输入及键盘的隐藏](./dev-basic/keyboard.md)：讲解输入框相关的知识点，同时讲解下如何隐藏键盘；
 - [Alert窗和Action Sheets](./dev-basic/alert.md)：弹窗是比较常用的交互形式，弹弹弹，弹走鱼尾纹~~

### 实战部分

 - 1. [hello world](./hello-world/README.md)：踏出第一步，包含了基本的环境搭建；


### 番外篇
 - [13个小技巧帮你征服Xcode](http://benbeng.leanote.com/post/13%E4%B8%AA%E5%B0%8F%E6%8A%80%E5%B7%A7%E5%B8%AE%E4%BD%A0%E5%BE%81%E6%9C%8DXcode)：能帮助你提高生产力的Xcode设置；
 - [icon stamper](https://github.com/tylergaw/icon-stamper)：一键生成iOS多种图标尺寸的插件，附带 [说明](http://www.ui.cn/detail/77876.html)

## 声明

本系列文章偏向于 **action** ，所以假定读者有相关语法基础；当然我也会在项目教程中适当提及所需要的关键语法，如果还有问题的，请提issue；

感谢互联网，本系列知识内容全部来源于互联网，但我可以保证里面所有的字全部都是自己码出来，图也是挨个截出来的，绝非单纯的 copy&paste；

作为一名初学者，一步一个脚印，与君共勉；

## 相关文档

 - [wiki首页]()：比较详细记录自己文档实现的过程
 - [milestone](https://github.com/boycgit/swiftlearn/milestones)：为学习swift立下目标，以 **里程碑** 式展现出来
