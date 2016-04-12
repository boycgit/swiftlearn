# Hello world

是不是很想用swift写一个小软件？那首先要搭建好环境哦~

本文总结自：

 - [Developing iOS Apps Part 1](http://jamesonquave.com/blog/developing-ios-apps-using-swift-tutorial/)
 - [Swift创建简单的Hello World项目](http://www.tianmaying.com/tutorial/swift-hello-world)

本人开发环境：

 - Xode 7.2.1 (7C1002)
 - OSX EI Captian 10.11.3

## 学习目标

 - 在Xcode创建最基本的应用
 - 在控制台和Table View中打印 “hello world”


## 学习步骤

### 控制台输出
选择 `iOS -> application` 下的 **single-view application** 模板

![app](http://ww3.sinaimg.cn/large/514b710agw1f2u47oanprj20ka0eewgk.jpg)


并选择 **swift** 作为开发语言：

![swift](http://ww4.sinaimg.cn/large/514b710agw1f2u471ichaj20ka0ee0u1.jpg)

点击确定之后，就创建好基本的应用框架；

> Xcode已经为我们创建了一个简单的MVC(Model-View-Controller)应用。
> 视图View在Main.storyboard里面
> 控制器Controller为ViewController.swift
> 模型Model则需要我们自己写代码来创建

在工程目录中找到 **AppDelegate.swift** 文件，双击打开，并在图中箭头所指的地方输入 `print("Hello World")`；

![hello print](http://ww1.sinaimg.cn/large/514b710agw1f2u469gdtkj20qo0gy0x0.jpg)

然后点击运行按钮，会默认打开iphone模拟器，当然你在模拟器上是看不到任何输出的，你所期望的Hello World出现在右下角那儿；

这里的print类似于`js`中的 `console.log `，用于控制台输出内容；

### storyboard

上面仅仅是简单介绍，做完之后可能没有啥成就感；那么接下来真正往“屏幕”上添加一些东西，或许能让自己觉得更加有成就感

那么我们接下来在 tableView 组件中展现 hello world

现在用Swift写iOS程序比较方便，直接拖拽就能将UI组件放置在屏幕上了；打开 **Main.storyboard** 文件，在右边的组件库中通过 **搜索关键字** 筛选出所需要的 Table View 组件，直接拖拽到storyBoard里，并调整大小适合窗口：

![drag](http://ww2.sinaimg.cn/large/514b710agw1f2u625gqbnj20qa0kumyw.jpg)

（你可以运行查看效果，是典型的表格形式）


然后关联界面和代码，按住 ctrl + click + 拖拽 ，将tableView和Controller关联起来，这样代码就能和界面关联起来，方便Controller控制代码：

![outlets](http://ww1.sinaimg.cn/large/514b710agw1f2u64c1nhqj206v07b0t4.jpg)

拖拽 **两次** 分别选中 `dataSource` 和 `delegate`

> 这种关联方式叫 **Outlets** 

### ViewController 代码

之后就是更改 **ViewController.swift** 文件中的代码，用于控制视图展现；

先将

```swift
class ViewController: UIViewController {
```

更改成：

```swift
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
```

也就是要实现`UITableViewDataSource` 和 `UITableViewDelegate` 这两个接口；

这个时候Xcode会提醒你的代码存在问题，这是因为我们没有实现 `UITableViewDataSource` 中的两个方法导致的；

具体是哪些方法呢？ **Commond + 单击** 关键字 `UITableViewDataSource` 就能跳到该协议的定义处，最顶上那两个就是：

![proto](http://ww1.sinaimg.cn/large/514b710agw1f2u6bvqsenj20id08i785.jpg)

即：

```swift
public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
```

 - 第一个是告诉tableView有多少行
 - 第二个是告诉tableView单元格里面展示什么内容

我们这里写上

```swift
func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
   return 10
}
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
 
   cell.textLabel?.text = "Row #\(indexPath.row)"
   cell.detailTextLabel?.text = "Subtitle #\(indexPath.row)"
 
   return cell
}

```

好了，这样就不报错，编译代码展现的结果为；


![result](http://ww2.sinaimg.cn/large/514b710agw1f2u6mjrif3j20ac0dvgm6.jpg)


## 疑问

有同学肯定会问，我用一个组件的时候，去哪里获取应该设置的属性呢？

比如Table View，我怎么知道必须要实现那两个方法？怎么知道内容如何写呢？

还有，我怎么就知道 **indexPath** 里面有个 `row` 属性呢？

总之，我该去哪儿查？



