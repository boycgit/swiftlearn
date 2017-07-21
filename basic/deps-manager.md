# 使用包管理器

 - [CocoaPods详解之----使用篇](http://blog.csdn.net/wzzvictory/article/details/18737437)：对新手友好的教程，包含了踩坑经验，图文并茂；看完这个系列教程，个人觉得没必要自己编写教程了；不过在使用时候可能需要替换pod repo，可以参考[iOS CocoaPods 安装笔记（持续更新）](http://www.jianshu.com/p/32d9cfb91471)；如果使用
 - [Carthage使用心得-让自己的项目支持Carthage](http://www.jianshu.com/p/bf263c596538)：详细讲解如何在项目中使用Carthage
 - [iOS依赖管理工具的使用-CocoaPods](http://www.jianshu.com/p/86e697beb770)：介绍性文章，很不错
 - [用CocoaPods做iOS程序的依赖管理](http://blog.devtang.com/2014/05/25/use-cocoapod-to-manage-ios-lib-dependency/)：简单明了，其中 **为自己的项目创建 podspec 文件** 值得一看；

目前iOS的依赖管理工具有CocoaPods和Carthage(只支持iOS8+)。

## CocoaPods

为了学习 realm 的知识，我需要安装 realm 依赖包，不过很折腾的是期间使用这个工具存在很多问题，下面我一一讲解如何解决这些问题的

### pod update / pod install 命令过长


#### A. 原因分析
使用CocoaPods的同学第一步肯定是会遇到这个问题的，这是因为所有的项目的podspec文件都托管在 https://github.com/CocoaPods/Specs 上,在执行 `pod setup`时，CocoaPods 会将这些podspec索引文件 **更新** 到本地 **~/.cocoapods/** 目录下。

我们看一下 `pod setup` 期间具体干了什么事情：

```shell
> pod setup --verbose                                                           

Setting up CocoaPods master repo
  $ /usr/local/bin/git remote set-url origin https://github.com/CocoaPods/Specs.git
  $ /usr/local/bin/git checkout master

Updating spec repo `master`
  $ /usr/local/bin/git pull --ff-only
```

截图如下：

![pod setup](http://ww4.sinaimg.cn/large/006y8lVagw1f85ou9yrfnj30hq045wf1.jpg)

从上面可以看出 **Specs** 是一个 Github 仓库，所谓的更新，其实就是 `git clone` 官方仓库到本地的 `~/.cocoapods/repos/master` 目录下，然后再执行 `git pull --ff-only`来 merge 最新的更新；

![放在master目录下](http://ww2.sinaimg.cn/large/006y8lVagw1f85ozlyoydj30dl0bddg2.jpg)；

我们平时执行 `pod repo add xxx https://github.com/xxxx/Specs.git` 就会在这个目录下新增一个名字为 `xxx` 的 github 仓库了


理解了上面，就不难得知，**用户之所以慢的原因就是 clone 这个仓库很慢导致的**：这个官方仓库大约是 **509.7M**左右（后续肯定还会增加），问题是文件超级多，数量达到 **83万** 个左右；（本地下完之后，使用系统自带查看其大小的时候都得花半分钟时间）

**文件数量多，在国内访问Github的速度又很慢**，雪上加霜，这才导致 `pod setup` 压根儿没法进行啊；

#### B. 解决方案

问题是找到了，怎么办呢？！

核心就是想办法把这个仓库下载下来，于是就有两种方案；


**方案一：替换master仓库**

这个方案在网上是提的最多的，凡是涉及到这个问题的，基本会建议通过命令更换成国内仓库地址（从官网clone过来），比如替换成 coding 上的镜像或者是 oschina 上的镜像

```shell
pod repo remove master
//coding 上有每日更新的，建议使用这个
pod repo add master https://git.coding.net/CocoaPods/Specs.git

//或者用oschina，但是https 好像有问题，一直是403，所以用ssh的方式，这里需要到官网去配置ssh key
pod repo add master https://git.oschina.net/akuandev/Specs.git
```

> 来自文章 [CocoaPods详解之----使用篇](http://blog.csdn.net/wzzvictory/article/details/18737437)

不知道什么原因，一旦我 remove 掉 master 之后再 add 回去的时候，cocoapods 会 **很聪明地** 会自动 add **自己官网的github** 地址，而不是我们指定的地址！！！

估计我的版本是 `1.0.1` ，而教程中的版本基本是 `0.0.39+` ，所以方式可能不一样吧；

无论如何，这条路行不通；何况这种方案有一种风险就是 **第三方库的更新没有官方及时，导致有些依赖可能会丢失**，也是一种隐患；

**方法二：手动下载官网repos**

还是这篇[iOS CocoaPods 安装笔记（持续更新）](http://www.jianshu.com/p/32d9cfb91471)文章给出了一个思路：自己去下载官方 repo ，然后放到 `~/.cocoapods/repos/` 目录下即可；

自己下载有两种做法：
 
 1. 使用`cd ~/.cocoapods/repos/ && git clone https://github.com/CocoaPods/Specs.git master`，不过这种方式会因为下载文件太多，导致github直接断开连接；我试了好几次都这样，放弃了
![下载失败](http://ww4.sinaimg.cn/large/006y8lVagw1f85pdsn7s9j30ik03i74s.jpg)
 2. 真是命苦啊，于是跑到官网下载客户端 **Github Desktop**，然后用客户端保证下载的稳定性；如果这条路还不行的话，我真的是没有办法了；
![使用Github Desktop下载](http://ww4.sinaimg.cn/large/006y8lVagw1f85qaenicnj30c7071dge.jpg)

好在毕竟是自家亲人，**Github Desktop** 下载自己的网站上资源的稳定性杠杠的，花费1个小时左右（看网速而定）就下载完毕了；

等等，这还没完！！ 

下载完毕之后，需要执行一步，`pod setup`，走一下过场，因为此时你已经下载完了，所以这个步骤基本不需要花费什么时间，静静地等他设置完毕即可；时间有可能还会有点长，但基本没问题

总算看到完成的状态了，泪流满面啊！！

![pod setup 完成](http://ww3.sinaimg.cn/large/006y8lVagw1f85pzl1581j30j307675a.jpg)

#### C. 使用注意事项

可见更新一次Repos是多么的伤人，所以不必每次在安装依赖的时候去检查官网的更新；因此使用 `--no-repo-update` 跳过这个检查过程：

```shell
pod install --verbose --no-repo-update
```

这样安装依赖的速度就会提升很多，你可以每隔1个月再自己手动更新一次官网即可；

#### D. 个人感悟

从发现问题到解决问题，花费了我近1天的时间，主要都是花费在 **网络下载 - 下载失败 - 尝试重新下载 - 再失败 - 再下载...** 这样的苦循环中，直到最后用官方的 **Github Desktop**才真正克隆出到本地；

这个 Specs 仓库是干嘛用的呢，说白了就是检测依赖关系使用的，类似于数据库对应的映射表；个人觉得这方面 Node.js 的包管理器 npm 做得比较好，所有的依赖查询通过官网就查询到，不需要用户自己下载官方这么大的一个包；

有时候真的不是你能力不够，实在是因为网络太差啊！！


###  报错：The dependency `RealmSwift ` is not used in any concrete target

我使用的 Cocoapods 的版本是 `1.0.1` ，所以必须要指定 `target` 指令；

因此我的 Podfile 这么写是不行的：

```shell
platform :ios

pod 'AFNetworking', '~> 2.6'
```

需要修改成：

```shell
platform :ios, '8.0'
#use_frameworks!个别需要用到它，比如reactiveCocoa

target 'MyApp' do
  pod 'AFNetworking', '~> 2.6'
end
```

> use_frameworks! 这个是个别需要的


详见 http://blog.csdn.net/sjl_leaf/article/details/50506057 



