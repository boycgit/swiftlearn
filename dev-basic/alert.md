
## 1、alert窗
alert窗见过不少，最常见的常见就是 ios 应用上总会时不时弹出一个框，让你去给这个应用点赞....

之前我们将的UI组件都可以通过组件库拖拽创建，这一招对这两个组件不管用，**这两个组件必须用代码实现** ，这也挺特别的；

### 1.1、普通使用

这两个类归属于 **UIAlertController** 类（属于UIKit框架），通常创建的方式如下：

```swift
let alert = UIAlertController(title: "这是标题", 
      message: "内容写到这里来", 
      preferredStyle: UIAlertControllerStyle.Alert)
```

上面仅仅是创建了弹出窗口，我们还需要为其添加操作按钮，调用 **addAction** 方法即可；下面两行分别创建 OK 和 Cancel 按钮；

```swift
alert.addAction(UIAlertAction(title: "Ok", 
      style: UIAlertActionStyle.Default,
      handler: nil))

alert.addAction(UIAlertAction(title: "Cancel", 
      style: UIAlertActionStyle.Cancel,
      handler: nil))
```

![alert](https://lh3.googleusercontent.com/-4gLMGQ1ahr4/Vzb1ZPuujYI/AAAAAAAACo0/vrxulGvYe9E_-Gf3zp-se3_ucO-46bUcgCCo/s800/2016-05-14_17-49-34.png)

上面最后的handler参数用于传递按钮按下之后的回调函数，我们见一个例子：

```swift
let alert = UIAlertController(title: "Help", 
      message: "Would you like to call customer services?", 
      preferredStyle: UIAlertControllerStyle.Alert)

let dialActionHandler = { (action:UIAlertAction!) -> Void in 
    let alertMessage = UIAlertController(title: "Error",      
        message: "Sorry, unable to make a call at the moment.",
        preferredStyle: UIAlertControllerStyle.Alert)

    alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))

    self.presentViewController(alertMessage, animated: true, completion: nil)
}

alert.addAction(UIAlertAction(title: "Call +44 7922 394132", 
      style: UIAlertActionStyle.Default, 
      handler: dialActionHandler))

alert.addAction(UIAlertAction(title: "Cancel", 
      style: UIAlertActionStyle.Cancel, 
      handler: nil))
```

在这个例子中，展示一个Help的弹出框，询问你是否要拨打服务热线，你点击之后会再弹出一个Alert框，告知你目前打不出电话...

创建完之后，还要展现到storyboard上，调用viewController的 `presentViewController` 方法:

```swift
self.presentViewController(alert, animated: true, completion: nil)
```

### 1.2、添加输入框

除了加按钮之外，还能加输入框哦，只不过最多加两个，加多了不受理；这种场景最常见的就是让你输入用户名和密码，使用实例的 `addTextFieldWithConfigurationHandler`方法来达到这个目的

```swift
let alert = UIAlertController(title: "Enter name", 
      message: "", 
      preferredStyle: UIAlertControllerStyle.Alert)
                              
alert.addAction(UIAlertAction(title: "Ok", 
      style: UIAlertActionStyle.Default, 
      handler: nil))

alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in 
      textField.placeholder = "What is your name?" 
  })

self.presentViewController(alert, animated: true, completion: nil)
```

输入框有了，当用户点击确定的时候，要收集用户填写的信息，首先要获取这个输入框的实例，获取 **alert.textFields![0]** 属性即可：

```swift
let okActionHandler = { (action:UIAlertAction!) -> Void in

      var nameField = alert.textFields![0] as UITextField
      
      let alertMessage = UIAlertController(title: "Hello", message: "\(nameField.text)", preferredStyle: UIAlertControllerStyle.Alert)
      
      alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil)) 
      
      self.presentViewController(alertMessage, animated: true, completion: nil)

}

alert.addAction(UIAlertAction(title: "Ok",            
      style: UIAlertActionStyle.Default, 
      handler: okActionHandler))
```

## 2、action sheets

Action Sheet也是给用户展现一系列选择，这种组件和alert组件功能大同小异，主要不同点在于：

 - 首先，action sheets在 iphone 和 iPad 上的展现并不一样；iPhone上它呈现在底部，iPad上像个popover提示框，且在iPad上它也是 **没有Cancel** 按钮的，用户点击背景处就能隐藏掉它；
 - 该组件能够让其中一个按钮红色高亮显示，点击该按钮会销毁此组件，该红色文字按钮称为 **destructive button**
 - 在iPad端，不能在 **viewDidLoad** 方法中展现 action sheets
 - 不能整合输入框
 
创建方式类似，只是构造类型是 **UIAlertControllerstyle.ActionSheet**，添加销毁按钮的类型是 **UIAlertActionStyle.Destructive**：

```swift
let alert = UIAlertController(title: "This is the title", message: "This is the message", preferredStyle: UIAlertControllerStyle.ActionSheet)

alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))

alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))

alert.addAction(UIAlertAction(title: "Destructive", style: UIAlertActionStyle.Destructive, handler: nil))

self.presentViewController(alert, animated: true, completion: nil)
```

![action sheet](https://lh3.googleusercontent.com/-9B5zcv9THII/Vzb1ZH_P3WI/AAAAAAAACo4/7FLEn3-nQgQqvMd08n2vEMl2iH7CPfoAACCo/s800/2016-05-14_17-51-59.png)

在iPad端添加action sheet，使用下列的代码片段:

```swift
alert.modalPresentationStyle = UIModalPresentationStyle.Popover

if let popoverController = alert.popoverPresentationController { 
    popoverController.sourceView = sender as UIView; 
    popoverController.sourceRect = sender.bounds; 
}

self.presentViewController(alert, animated: true, completion: nil)
```

## 3、示例

本节示例代码放在当前目录下 **ActionSheetSample** 文件夹中；总体而言，本次示例操作过程很简单，上手很快的；

最终效果图：

![actionsheet](https://lh3.googleusercontent.com/-mbGKNp3OTeU/Vzbu3ZWxqqI/AAAAAAAACok/VZRCkAk8TV4BWmYn8-YXcqWueMODhUsYgCCo/s800/actionsheet.gif)

下面是较为详细步骤说明

**Tips**：
 - 手势识别内容，请移步[Responder 及 Touches事件](./touch.md)
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)

### 3.1、创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **ActionSheetSample**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）

### 3.2、添加按钮

点击选择 **Main.storyboard** 文件

从组件库里拖一个Button组件到storyboard上，双击之并修改文本内容为 **更改背景颜色**，修改按钮背景色为天蓝色（或者自己喜欢的颜色），文字颜色为白色

然后设置尺寸、位置约束：
 - 水平垂直居中
 - width:210， height:40
 

### 3.3、添加Action、代码

打开辅助编辑器，对按钮右键，拖动 **Touch Up Inside** 右边的小圆圈到 **ViewController.swift** 文件里创建一个关联的Action，命名为 **onPresentActionSheet**；

接下来就是点击 **ViewController.swift** 文件，往 **onPresentActionSheet** 方法里面添加如下逻辑代码：

```shell
    @IBAction func onPresentActionSheet(sender: AnyObject) {
        let alert = UIAlertController(title: "更改背景颜色",
                                message: "选择一种颜色",
                                preferredStyle:UIAlertControllerStyle.ActionSheet);
        alert.addAction(UIAlertAction(title:"红色",
            style:UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.view.backgroundColor = UIColor.redColor()
        }))
        alert.addAction(UIAlertAction(title:"绿色",
            style:UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.view.backgroundColor = UIColor.greenColor()
        }))
        alert.addAction(UIAlertAction(title:"蓝色",
            style:UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.view.backgroundColor = UIColor.blueColor()
        }))
        alert.addAction(UIAlertAction(title:"黄色",
            style:UIAlertActionStyle.Default,
            handler: {
                (action:UIAlertAction) -> Void in
                self.view.backgroundColor = UIColor.yellowColor()
        }))
        alert.addAction(UIAlertAction(title:"取消",
            style:UIAlertActionStyle.Cancel,
            handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
```

好了，点击运行按钮，就可以在模拟器中查看效果了，是不是很简单？

本示例仅仅是写了action sheet的示例，可以自己尝试alert弹出框效果~~
