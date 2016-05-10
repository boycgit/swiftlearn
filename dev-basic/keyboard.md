# 用户输入及键盘的隐藏

参考文章：
 - [IOS中键盘自动隐藏](http://devonios.com/ios-hide-keykeyboard.html)：这里对First Responder的讲解比较通俗易懂
 - [How to Dismiss UITextField’s Keyboard in your Swift App](http://www.codingexplorer.com/how-to-dismiss-uitextfields-keyboard-in-your-swift-app/)

## 1、单行文本输入框

供给用户输入文本的表单元素主要有两种，一种是UITextField（单行），另外一种就是UITextView（多行），这两种都可以通过组件库拖拽进来；

和web开发中的表单一样，很多属性（字体颜色、大小、对齐方式、占位符）都可以通过属性控制器直接设置，比较特殊的就是设置键盘类型，这种场景你应该见到过的，在号码输入框中点击会弹出拨号盘，这种键盘只显示数字；

键盘属性的设置在 **Keyboard Type** 中设置：

![keyboard type](https://lh3.googleusercontent.com/-cjc66lkGVz0/Vy_p58Yj1gI/AAAAAAAACmI/0dZwimQ7wZsduP1jGZoQuvr73xb9gT9kgCCo/s800/2016-05-09_09-30-12.png)

如果想获取字符串文本框里的字符串内容，使用 `.text` 属性即可，比如：
```swift
let text:String = usernameField.text;
```

点击输入框表示用户想输入东西，那么输入框就会成为 **First Responder** ，当一个输入区域成为First Responder时，就会自动弹出键盘啦~~

> 更多responder和手势识别内容，请移步[Responder 及 Touches事件](./touch.md)

在输入完毕之后，我们会点击键盘上的“Done（完成）”按钮，想隐藏键盘，我们需要在程序中对这一交互进行响应：通过storyboard为输入框创建名为 **Did End On Exit** 的 Action，在这个action里调用 `self.usernameField.resignFirstResponder();` 来解除 **First Responder** 角色即可；

> 更多Action的创建内容，请移步[自适应布局](../basic/adaptive.md)

这一招对有“Done（完成）”按钮的键盘管用，对数字键盘这类没有这按钮的就不好使；针对这类键盘，我们常常用另外一种交互代替：点击屏幕背景（点击非键盘区域）时隐藏键盘；

这个时候 **UITapGestureRecognizer** 就派上用场，三步走解决问题：

1、注册回调名，比如叫 `handleBackgroundTap`

```swift
func handleBackgroundTap(sender: UITapGestureRecognizer) {

}
```

2、在 `viewDidLoad` 方法中将该回调函数绑定到点击手势识别器（`UITapGestureRecognizer`）：

```swift
let tapRecognizer = UITapGestureRecognizer(target:self , action: Selector("handleBackgroundTap:"))

tapRecognizer.cancelsTouchesInView = false 
self.view.addGestureRecognizer(tapRecognizer)
```

3、最后实现`handleBackgroundTap` 方法：

```swift
func handleBackgroundTap(sender: UITapGestureRecognizer){ 
  self.usernameField.resignFirstResponder(); 
}
```

## 2、多行文本框

多行文本框和单行输入框大同小异，主要区别有：

 - 可以设置是否可编辑
 - 没有“Done（完成）”按钮，取而代之的是“return(回车)”按钮，因此只能通过 **UITapGestureRecognizer** 方式来隐藏文本区域；
 
 
推荐继续阅读文章[Swift - 文本输入框（UITextField）的用法](http://www.hangge.com/blog/cache/detail_530.html)，该篇文章言简意赅地总结该组件的用法

## 3、Demo

在这个demo中，我们实现最常见的登录场景，用户可以输入用户名和密码，当点击“登录”按钮的时候展示欢迎信息；（不涉及后台交互）

本节demo放在当前目录下的 **LoginSample** 文件中；效果图：

![keyboard demo](https://lh3.googleusercontent.com/-yk666gsrH0U/VzFAzLcCbPI/AAAAAAAACm0/aqIwO8eD24k-4yk0aLIBsOtemieoqTYAACCo/s800/gesture-capture.gif)

### 3.1、大致步骤

 - 创建 **Single View Application** 应用
 - 在storyboard上添加两个 **UILabel** 实例，分别展现为 **用户名：** 和 **密码：**
 - 添加两个对应的 **UITextField** 实例，用于用户的输入
 - 给每个输入框关联 **Did End On Exit** 事件，对应的回调函数名为 `dismissKeyboard()`，其该回调函数中通过调用 **resignFirstResponder** 来隐藏键盘
 - 增加 **UIButton** 实例，当用户点击的时候显示欢迎信息
 - 最后添加tap的手势识别器，当用户点击非键盘区域的时候隐藏键盘


### 3.2、详细步骤

#### A. 创建单应用程序

在iOS项目卡下选择 **Single View Application** 应用程序，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）

#### B. 添加两个UILabel

从组件库里拖两个Label到storyboard上，通过属性器设置显示文本分别为 **用户名** 和 **密码**；选中两个文本Label，然后自适应文本内容，快捷键是（Ctrl + =）：

![auto layout](https://lh3.googleusercontent.com/-Fuy1sH9wfhg/VzFAyy-M3-I/AAAAAAAACms/AGfNLpCSbpgbd1lcsrxfuCDOXsOyy_9DwCCo/s800/2016-05-09_10-14-29.png)

然后设置这两个label尺寸、位置约束：
 - margin-top:15，margin-left:10
 - width:91， height:21
 

#### C. 添加两个UITextField

从组建库里拖拽两个Text Field 组件到画布上，分别设置两个组件的 placeholder（占位符） 值为 **输入用户名** 、 **输入密码** 

可以尝试着自己修改 **Keyboard Type** 布局类型，默认是default布局；

同样设置尺寸、位置约束：
 - margin-top:15，margin-left:10
 - width:200， height:30


#### D. 添加登录按钮

最后添加一个Button组件，双击修改内容为 **登录**，同时修改按钮底色为蓝色，文字颜色为白色；

设置尺寸、位置约束:
 - margin-top:10，margin-left:116
 - width:64， height:40

> 如果觉得这样上面排版不适合自己的口味，可以拖拽UI元素到合适的位置，然后点击 **Update Constraints** 即可；

最后获得的页面布局长这样：

![final layout](https://lh3.googleusercontent.com/-AXodLKnfCcs/VzFGmUfgSVI/AAAAAAAACm8/SUrFsItVaDE8xRDvjVhWf4jPGOB2y0tPgCCo/s800/2016-05-10_10-25-10.png)


#### E. 创建outlets、action

记得 **打开辅助编辑器** ，
然后在textField上右键，然后拖拽 **New Referencing Outlet** 右边的小圆圈到辅助编辑器里创建Outlets，分别命名为 **usernameField** 和 **passwordField**；

分别给两个textField创建 **Did End On Exit** 对应的Action，不过这里的流程稍微有点儿不同；创建用户名对应textfield的action的时候，流程差不多，右键然后选择 **Did End On Exit** 右边的小圆圈到辅助编辑器，命名成 **onDismissKeyboard**；

![did end on exit](https://lh3.googleusercontent.com/-LmBpDsihras/VzFAywTiLVI/AAAAAAAACms/0gI8lUHcAzwiTF7GZKMP-ti9T2nSszhswCCo/s800/2016-05-09_10-45-50.png)

而为密码对应的textField创建 actions 的时候我们是想 **复用onDismissKeyboard方法**，此时不能网辅助编辑器中拖，而是往 **顶部的ViewController图标处拖**（详见下图），然后选择弹出的onDismissKeyboard即可：

![drag view controller](https://lh3.googleusercontent.com/-mLwLxW6Dl2Y/VzFAyw_me2I/AAAAAAAACms/tYFEs8ZxP84R9dGt5572ahgW94G8DKncwCCo/s800/2016-05-09_10-47-10.png)

然后添加下面两行代码实现 **onDismissKeyboard** 方法：

```swift
usernameField.resignFirstResponder()
passwordField.resignFirstResponder()
```

这里调用 `resignFirstResponder` 方法，表示用户点击键盘上的“完成”按钮时隐藏软键盘；

#### F. 为Login按钮创建action

给登录按钮添加action，命名为 **onLogin**，添加下列代码来实现它：


```swift
usernameField.resignFirstResponder()
passwordField.resignFirstResponder()

let userName:String = usernameField.text! 
let length:Int = userName.characters.count

if length == 0 {
    return 
}

let alert = UIAlertController(title: "", 
        message: "Login succesfull", 
        preferredStyle: UIAlertControllerStyle.Alert)

alert.addAction(UIAlertAction(title: "Ok", 
          style: UIAlertActionStyle.Default, 
          handler: nil))

self.presentViewController(alert, 
          animated: true, 
          completion: nil)
```

#### G. 添加单击手势识别

为了实现单击背景隐藏软键盘，需要添加单击手势识别功能；

这一次我们通过程序的方式引入这项功能（之前是通过UI库拖拽的），在 **ViewController.Swift** 中的 **viewDidLoad** 方法中，在 `super.viewDidLoad()` 后添加下列代码：

```swift
let tapRecognizer = UITapGestureRecognizer(target:self,
                                           action:#selector(ViewController.handleBackgroundTap(_:)))
tapRecognizer.cancelsTouchesInView = false
self.view.addGestureRecognizer(tapRecognizer)
```

这里绑定单击事件的回调函数名为 **handleBackgroundTap()**，因此需要在`ViewController.swift` 中添加 **handleBackgroundTap()** 方法：

```swift
    func handleBackgroundTap(sender:UITapGestureRecognizer){
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
```

#### H. 运行查看效果

至此已经完成所有的工作，点击运行按钮就能看到效果了；

注意了，新同学点击输入框的时候 **并没有弹出软键盘** ，这其实并不是你程序的bug，需要设置 iOS 模拟器的键盘控制，取消 **“Connect Hardware Keyboard”** 选项：

![uncheck keyboard](https://lh3.googleusercontent.com/-S7bNFOI36yw/VzFAzN5XggI/AAAAAAAACm0/2xRayGZUmSUpKLoIHQUbh0K9M-0R9YaegCCo/s800/2016-05-10_09-53-20.png)

我当时遇到这个问题，来回检查半天也没找出个所以然来，都要抓狂暴走了，最后总算在StackOverflow上[Swift: Become First Responder on UITextField Not Working?](http://stackoverflow.com/questions/25353687/swift-become-first-responder-on-uitextfield-not-working)中找到了答案；
