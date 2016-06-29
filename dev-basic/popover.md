# Popover层及Modal框

 - [A Beginner’s Guide to Presentation Controllers in iOS 8](http://www.appcoda.com/presentation-controllers-tutorial/)；以多种方式呈现弹出层
 - [THE SWIFT SWIFT TUTORIALS: ADDING MODAL VIEWS AND POPOVERS](https://makeapppie.com/2014/08/30/the-swift-swift-tutorials-adding-modal-views-and-popovers/)：初学者教程
 - [Adding a Modal Dialog to a UIViewController in Swift](http://tim-sanders.blogspot.com/2015/04/adding-modal-dialog-to-uiviewcontroller.html)：超级简单的入门教程

**Popovers** 和 **Modal** 这两者的用处都是 **给用户提供暂时性的信息**，展示的信息都是有上下文环境的，而且和用户的行为有关；

这两种组件对样式的交互都具有中断性质，用户必须首先优先处理弹出层才能继续恢复原来的操作；

弹出层仅仅是在 **iPads** 应用上回呈现，而对话框在iPad和iPhone上都可以出现；

## 1、Popover和Modal

用户点击某个按钮之后出现弹出层，然后在层外点击会隐藏该层；

弹出层的创建，使用 **popover presentation segue**连接两个viewController即可；

Modal框最常见的是通过 **Present Modally** 方式从一个view 以 segue 连接到另外到view上；

呈现样式有：

 - Full Screen
 - Current Context
 - Form Sheet
 - Page Sheet

默认的展现方式是占据整个屏幕，**最常使用的是form sheet方式**，在iPhone上 form sheet 和 full screen 的表现形式看上去是一样的，而在iPad上则form sheet更像是model对话框的样子；

要关闭modal的话，不能使用segue提供的方法，而是在Modal所在的view controller中调用 **dismissViewControllerAnimated** 方法：
```swift
@IBAction func onDismissModalView(sender: AnyObject) { 
    self.dismissViewControllerAnimated(true, completion: nil); 
}
```

该方法提供一个modal消失之后的回调函数作为参数；

除了使用segue呈现Modal之外，还可以使用下列代码片段临时创建一个Modal框（假设绑定到 UIButton 实例上）：
```swift
@IBAction func onPresentModalView(sender: AnyObject) {

  let modalViewController:ModalViewController = (self.storyboard!.instantiateViewControllerWithIdentifier ("ModalViewController") as? ModalViewController)! 
  modalViewController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
  self.presentViewController(modalViewController, animated: true, completion: nil)

}
```
## 2、实例：创建Popover层

本节示例代码放在当前目录下 **PopoverTest** 文件夹中；所用到的图片资源放在该目录中的`images`文件夹内

最终效果图：点击"图片信息"就会弹出一个展示层，比较简陋

![result](https://lh3.googleusercontent.com/-5_MoDfHO8eY/V3MoVtTlInI/AAAAAAAAC0Y/sLz-w8w9h4InuaOHwa5Ees-hO8JPcGIFwCCo/s800/popover.gif)
 
下面是详细步骤。

**Tips**：
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)
 - 有关scene、segue相关细节，请参看[理解storyboard](../basic/storyboard.md)

### A. 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **PopoverTest**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）

点击 **Assets.xcassets** ，然后右键新建名为 **Sunflower** 的图片集，打开目录下的**Images**文件夹，将其中的 **Sunflower_1x.jpg** , **sunflower_2x.jpg** 以及 **Sunflower_3x.jpg** 拖拽到对应类目中去

### B. 添加UI元素

先从组件库里拖拽一个 **toolbar** 到界面的底部，设置其位置Pin属性：
 - 不要勾选 **Constrain to margins** 选项
 - margin-left：0
 - margin-right：0
 - margin-bottom：0
 - height：40

之后双击修改工具栏默认的按钮名为 **图片信息**；

接着我们拖拽 **UIImageView** 到默认的scene上，同样设置位置Pin属性：
 - 不要勾选 **Constrain to margins** 选项
 - margin-left：0
 - margin-right：0
 - margin-bottom：0
 - margin-top：20


然后给这个image view 创建名为 **imageView** 的outlet

### C. 给view controller添加代码

更新一下view controller中的代码，先新增一个变量：

```swift
var image:UIImage
```

然后在 viewDidLoad 方法中给这个变量赋值：

```swift
image = UIImage(named: "Sunflower")
imageView.image = image 
imageView.contentMode = UIViewContentMode.ScaleAspectFit
```

之后会创建segue，这里先实现 `prepareForSegue(segue: sender:)` 方法：

```swift

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imageInformationSegue"{
            let viewController:ImageInformationViewController = segue.destinationViewController as! ImageInformationViewController
            viewController.imageBeingDisplayed = self.image
            
        }
    }
```

### D. 创建新的scene

右键导航栏，选择新建 **Cocoa Touch class** 文件，类名为 **ImageInformationViewController** （确保其继承自 **UIViewController** 类）；

接着我们从组件库里拖拽新的 View Controller 组件到画布上，同时在Identity监视器中设置 **Class** 属性为 **ImageInformationViewController**；



继而我们在这个新scene上添加3个label（名字分别为 **高度**, **宽度** 和 **色彩域**）和对应的3个input，按照下表设置尺寸约束：

| 元素  | Left  | Top  | Right  | Width  | Height  |
|---|---|---|---|---|---|
| 高度 (Label)  | 16  | 20  |   | 115  | 21  |
| 高度 (Input)  | 24  | 0  | 16  |   | 30  |
| 宽度 (Label)  | 16  | 26  |   | 115  | 21  |
| 宽度 (Input)  | 24  | 18  | 16  |   | 30  |
| 色彩域 (Label)  | 16  | 26  |   | 115  | 21  |
| 色彩域 (Input)  | 24  | 18  | 16  |   | 30  |

效果图如下：

![result](https://lh3.googleusercontent.com/-J5GbKWyO71M/V3Mwm-0d-rI/AAAAAAAAC0o/vhKTU7FydfYqBueoVgSoXfHllo-Ym2-uACCo/s640/2016-06-29_10-21-04.png)


之后分别为这三个input创建outlet（在文件 **ImageInformationViewController.swift** 中）：`imageHeight`, `imageWidth` 和 `imageColorSpace`

### E. 添加代码逻辑

我们在 **ImageInformationViewController.swift** 添加必要的代码：

首先创建从segue传来的图片对象变量：

```swift
var imageBeingDisplayed:UIImage!
```

在 **viewDidLoad** 方法中添加以下代码：

```swift
        let imageSize = imageBeingDisplayed.size
        let height = imageSize.height
        let width = imageSize.width
        
        imageHeight.text = "\(height)"
        imageWidth.text = "\(width)"
        imageColorSpace.text = "RGB"
```

最后只剩下一件事情，就是创建 **从工具栏按钮到新scene的segue关联** 了
  1. 先选中工具栏上的 **图片信息** 按钮
  2. 按住 **Ctrl** 键拖拽到新scene上，在弹出的右键菜单中选择 **Present as Popover**，这样就创建了segue了
  3. 选中该segue（连线上的中点），在属性监视器中设置其 **identifier** 为 `imageInformationSegue`

自此已经完成所有设置，点击运行按钮就能查看到效果了

