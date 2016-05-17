# 在视图中添加图片

UIKit提供的 `UIImage` 和 `UIImageView` 这两个类能让用户在视图中呈现图片；

## UIImage

UIImage是用来代表图片对象的，该对象通过读取文件或者通过 **Quartz** 原型创建而成，**一旦创建就不能修改**；你不能通过UIImage获取图片的底层数据，比如某点的RGB值什么的；

图片资源毕竟占用了大量的存储资源，平时建议不要使用超过 **4096x4096** 大小的文件；

使用UIImage也是比较简单，首先你要将图片文件放在 **Assets.xcassets（资源目录）** 中，图片资源放在这里，一是方便统一管理，二是能直接让程序根据集合名访问到；资源目录中放置三种类型的图片：

 - Image Sets：包含各平台所需要尺寸的图片集
 - App Icon：特殊的图片集，用户放置应用图标
 - Launch images：app启动图片
 
 图片集 **名字必须是唯一的**，方便在 Interface 编辑器 或者 代码中引用；通过 **Editor ➪ New Image Set** 新建图片集，然后双击就能修改名字了

图片集合中至少要包含一张基本图片（1x版本的），不过建议也要准备 2x 和 3x 版本的，对于Retina屏会自动使用2x版本，而对于iPhone 6 Plus会自动使用3x版本；当然也可以自定义针对特定设备的图片尺寸：

![device](https://lh3.googleusercontent.com/-Q3ahabozU7o/Vzp1MQbPNyI/AAAAAAAACpM/fDhsHqT8YmseQuzAD6nK239GonDbGJvvwCCo/s800/2016-05-16_09-26-51.png)

如果你创建了一个名为 **Cat** 的图片集，通过 **UIImage** 就能创建并引用它了：

```swift
let catImage:UIImage! = UIImage(named: "cat")
```

通过 **UIImage**  创建的图片对象会自动实现内部缓存，就算之后重复载入同一个图片资源，使用的仍然是同一个对象，该对象在不同的UIImage实例之间共享；

除了载入本地文件之外，还可以通过URL载入网络图片资源；（这里只列举同步载入图片的写法，异步载入方式待后续补充）

```swift
let url = NSURL(string:"http://...") 
let data = NSData(contentsOfURL: url!) 
let image:UIImage! = UIImage(data: data!)
```

## UIImageView

图片对象有了，接下来就是展示图片；使用 **UIImageView** 对象可以展示单个或者多个轮播图；

直接从组件库拖拽 **Image View** 到storyboard上就可以创建了，可以通过属性器中的 **image** 属性设置默认展示图片；也可以通过创建outlets，然后设置image属性：

```swift
imageView.image = UIImage(named: "cat")
```

如果要展现帧动画，只需要将 **UIImage数组** 复制给 **animationImages** 属性就行：

```swift
let animationImageList:[AnyObject] = [ 
      UIImage(named: "frame1")!,
      UIImage(named: "frame2")!, 
      UIImage(named: "frame3")!, 
      UIImage(named: "frame4")!
]

imageView.animationImages = animationImageList
```

设置完毕之后，开始动画：

```swift
imageView.startAnimating()
```

也可指定动画持续的时间：

```swift
imageView.animationDuration = 2
```


## Demo

在这次的demo中，我们创建一个 **寻找宝藏** 的小应用来练习，大致步骤如下：

 1. 创建单应用程序
 2. 导入图片资源，图片源文件放在当前目录 `image` 文件夹里
 3. 添加 UILabel 组件
 4. 在画布上添加两个 UIImageView 实例
 5. 如果用户点击图片上会展示alert提示
 6. 如果点击图片上某个特定区域，会展示一个轮播动画（表示找到宝藏了）
 
本节示例代码放在当前目录下 **TreasureHunt** 文件夹中；所用到的图片资源放在该目录中的`images`文件夹内

最终效果图：点击图中蓝色的珠子会弹出一个小动画，比较简陋

![result](https://lh3.googleusercontent.com/-xBjrHW4vtAM/VzsIJbJmICI/AAAAAAAACp8/VgK65n-_nHoDXC73QYJvy7a791KLniaJACCo/s800/treasureHunt.gif)
 
下面是详细步骤。

**Tips**：
 - 手势识别内容，请移步[Responder 及 Touches事件](./touch.md)
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)

### 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **TreasureHunt**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）

### 添加图片资源

打开 **Assets.xcassets** 目录，通过右键中的 **New Image Set** 创建新的图片集；

首先创建名为 **beats** 的状态集，将图片beads1x.png, beads2x.png, 和 beads3x.png 拖拽到对应的框框中；同样的过程创建 **animframe1** - **animframe6** 另外这6个图片集，用作变化的图；

### 添加UILabel

点击打开 **MainStoryboard.storyboard** 文件

从组件库中拖拽UILabel，双击将文字内容修改为 **请点击蓝色珠子**，同时设置尺寸约束:

  - 水平居中
  - 距离顶部10 （不要勾选Constrain to margins）


### 添加两个UIImageView

首先从组件库里拖拽1个 **Image View** 放在storyboard上，通过属性检查器设置 `image` 属性为 **beads**，这样默认就能展示珠子的图片了；

接下来调整ImageView的适配大小，设置 `View Mode` 为 **Aspect Fill**，接着通过菜单 **Editor ➪ Size to Fit Contents** 展示出图片全貌。

然后设置图片尺寸约束：

  - 水平居中
  - 距离顶部10 （不要勾选Constrain to margins）

然后打开辅助编辑器，创建名为 **largeImage** 的outlets，第一个Image View创建完毕；继续

同样的拖拽 **Image View** 放在storyboard上，通过属性检查器设置 `image` 属性为 **animframe1**；，设置 `View Mode` 为 **Aspect Fill**，接着通过菜单 **Editor ➪ Size to Fit Contents** 展示出图片全貌。

同样最后设置图片尺寸约束：

  - 水平居中、垂直居中

### 添加行为代码

最后添加手势识别功能，当用户点击图中蓝色珠子的时候，显示轮播图；

首先在 `viewDidLoad` 中添加如下代码：

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 注册单击事件
        let tapRecognizer = UITapGestureRecognizer(target:self,action:Selector("handleTap:"))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        // 设置动画帧
        let frameArray:[UIImage] = [
            UIImage(named:"animframe1")!,
            UIImage(named:"animframe2")!,
            UIImage(named:"animframe3")!,
            UIImage(named:"animframe4")!,
            UIImage(named:"animframe5")!,
            UIImage(named:"animframe6")!
        ]
        animatedImage.animationImages = frameArray
        animatedImage.animationDuration = 0.5
        animatedImage.animationRepeatCount = 1
        animatedImage.userInteractionEnabled = false
        animatedImage.hidden = true
    }
```

这里设置一个单击事件回调函数，在 **ViewController.swift** 具体实现代码是：

```swift
    func handleTap(sender:UITapGestureRecognizer){
        let startLocation:CGPoint = sender.locationInView(self.largeImage)
        let scaleFactor = self.largeImage.frame.size.height / 430.0;
        if((startLocation.y >= 211 * scaleFactor) && (startLocation.y <= (211+104)*scaleFactor)){
            animatedImage.hidden = false
            animatedImage.startAnimating()
        }
    }
```

最后点击运行即可看到效果；
