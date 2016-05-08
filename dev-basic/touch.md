参考文章 
 - [Swift 如何实现手势识别](http://www.oschina.net/translate/implement-gesture-recognizers-swift) ：译文，对新手来讲是很不错的入门文章
 - [Hit-Testing in iOS](http://smnh.me/hit-testing-in-ios/)：测试风格的文章，全文高清图片展示手势原理


## 1、Responder

初次遇到 Responder 这个概念，我也是丈二和尚摸不着头脑，去翻了官方[Responder object](https://developer.apple.com/library/ios/documentation/General/Conceptual/Devpedia-CocoaApp/Responder.html)的解释大致有些明了；

**Responder** 归属于事件系统的，捕获事件并对事件做出响应，相当于JS中的 **callback** （回调函数）

所有的responder的是继承自 **UIResponder** 这个类；

常见的UI对象都是responder，比如 **视图控制器(UIViewController objects)** 就是responder；

### 1.1、First Responder

在一个应用中，能够 **最先** 捕获多种类型事件（key事件、motion事件等等）的 responder，就是让人羡慕啥的 First Responder 啦； First Responder 就是“处理事件的第一个回调函数”，类似于打战时候的前锋，率先拦住事件并对事件进行响应；

First Responder 并不是固定的，可以通过程序更替成其他对象；好比党派竞争一样，当美国总统的可以是民主党人也可以共和党人，需要按一定的程序指认出来就行；比如 常用的 **mouse** 事件、**touches** 事件和 **gestures** 事件，就是先通过被点击元素对象处理 —— 你点击一个按钮，无论该按钮是否是 First Responder，都会优先处理这个点击事件；

除上述自动转化的情况，每个 responder 要成为 First Responder，通过声明下列语句就行，只是最好让视图中最合适的元素胜任会比较合适； 

```swift
(BOOL)canBecomeFirstResponder { return YES; }
```


## 1.2、Responder链

当 First Responder 无法处理当前事件时候，就会将该事件传递给下一个responder，如果下一个还是不能处理就继续传递给下一个，一直等到这个消息被消化；如果最终没有任何一个responder能处理它，当前app就会忽视这个消息。这种传递机制称为 **responder链**;

iOS的 responder链 如下图所示（截自官网）：

![responder chain](https://lh3.googleusercontent.com/-U5Uw_k7Y_Fc/Vy8Ey4cmfbI/AAAAAAAAClM/AgKhk6fuNr8X4R9_Eub8ELmw2iWnjdk7ACCo/s800/2016-05-08_17-17-29.png)

 1. 事件首先被 **First Responder** 或者 **手指点击处的view** 处理
 2. 如果处理不了，就传递给 **[视图层级](https://developer.apple.com/library/ios/documentation/General/Conceptual/Devpedia-CocoaApp/View%20Hierarchy.html#//apple_ref/doc/uid/TP40009071-CH2-SW1)** 中的 父视图 处理，一直延伸到 window对象，最后到 全局app 对象
 3. 如果其中的视图处理不了该事件，若 **该视图是被 view controller** 控制着，那么这个 view controller 会成为下一个 responder


## 2、Touch事件

无线端交互很大部分是基于手指的（非手指交互的还有摇一摇等），手指相关的事件包含两种 **touches**（触摸点击）和 **gestures** （手势），别问我这两个单词都用复数形式，我也不清楚，只是大部分英文教程是这么称呼的，我也沿用下来；

 **touches**（触摸点击）和 **gestures** （手势）都是 **UIEvent** 类的实例，并且都归属 **UIApplication** 这个类来管理

在[官方文档-Events (iOS)](https://developer.apple.com/library/ios/documentation/General/Conceptual/Devpedia-CocoaApp/EventHandlingiPhone.html#//apple_ref/doc/uid/TP40009071-CH13-SW1)很明白地阐述了如何处理Touches事件；

每当用户在屏幕上触摸时，系统 **会产生一个事件对象，并将相关信息打包进这个对象**， 这个对象的类型是 **UIEvent**；


为了让某个视图（继承自）事先响应 touch 事件，两步走：
  1. 先让该视图对象重载`canBecomeFirstResponder`方法，并返回true
  2. 然后重载下述4个方法中的至少一个：

```swift
func touchesBegan(_ touches: Set<UITouch>, withEvent event: UIEvent?) 
func touchesMoved(_ touches: Set<UITouch>, withEvent event: UIEvent?) 
func touchesEnded(_ touches: Set<UITouch>, withEvent event: UIEvent?) 
func touchesCancelled(_ touches: Set<UITouch>?, withEvent event: UIEvent?)
```

> 自定义的 UIView 类需要覆盖上述方法，而系统自动的诸如 `UITextView`已经实现了（比如点击输入框会弹出键盘），就不必自己动手
> `touchesCancelled` 事件出现的时机比较特殊，当你触摸屏幕时恰好遇到 系统提示低内存啊、用户来电啊 这类情况就会触发；

## 3、Gesture识别

Touch事件是比较底层的事件，平时我们在手机上往往是多个手指一起来的，这种情况又很常见，所以库又提供了封装好的 **手势识别** 组件，省去了自己去判断 **用户放了几根手指在屏幕上、滑动了多长** 等一系列共同过程；

手势识别是 **[UIGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIGestureRecognizer_Class/)** 类是由 UIKit 框架提供的基类，具体还包含如下子类：
 - [UITapGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITapGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UITapGestureRecognizer)：单手指或多手指的点击事件
 - [UIPinchGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPinchGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UIPinchGestureRecognizer)：手指捏合操作（常用于照片放大等操作）
 - [UIRotationGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIRotateGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UIRotationGestureRecognizer)：手指旋转操作
 - [UISwipeGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UISwipeGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UISwipeGestureRecognizer)：手指轻扫操作，滑动看上一页、下一页等
 - [UIPanGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPanGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UIPanGestureRecognizer)：手指按住拖拽操作，常用于查看大图的不同部分
 - [UIScreenEdgePanGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIScreenEdgePanGestureRecognizer_class/index.html#//apple_ref/occ/cl/UIScreenEdgePanGestureRecognizer)：手指屏幕边缘拖拽操作，比较常见于处理多选好几页文字；
 - [UILongPressGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UILongPressGestureRecognizer_Class/index.html#//apple_ref/occ/cl/UILongPressGestureRecognizer)：手指长按屏幕操作；比如要弹出右键菜单等
 

添加手势识别有两种方式

### 3.1、通过界面拖拽



下面以一个简单demo展示如何在程序中使用手势探测：

 1. 添加一个 **Single View Application** 应用程序，应用名称 **GestureTest**
 2. 拖拽 UILabel 到页面中，设置约束（见下图），并为其创建 Outlets，变量名是 **gestureType**
 
![set constraint](https://lh3.googleusercontent.com/-NbdpXGggH4E/Vy8nRSwOthI/AAAAAAAACl4/cc_Wqev2SaQDYmK6YYYhds4mu3fkaJW2wCCo/s800/2016-05-08_19-45-22.png) 

 3. 在组件库中输入`gesture`关键字就能过滤出所要的手势了，拖拽 **Tap Gesture Recognizer** 到 storyboard

![gesture](https://lh3.googleusercontent.com/-ohoju9IN2tE/Vy8RB18XrKI/AAAAAAAAClg/YETA6r1YtDoe2qsnip_qeXYGIkEnF3NaQCCo/s800/2016-05-08_18-11-53.png)

 4. 右键为这个手势探测器创建一个Action，对应的方法名为 **onTapGestureDetected** ，创建过程如下：
 
 ![create outlets](https://lh3.googleusercontent.com/-BbGS-mtTeAo/Vy8mGaRXUAI/AAAAAAAACls/UIMSZmLYXzAS0u5JTNeeeecPiyoeRwFjgCCo/s800/2016-05-08_19-19-39.png)

 5. 最后在 **onTapGestureDetected** 方法中写上 `gestureType.text = "探测到事件：Tap"`，当用户点击屏幕的时候就更改label里面的文字内容；

最终 **ViewController.swift** 代码：

```swift

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gestureType: UILabel!
    @IBAction func onTapGestureDetected(sender: AnyObject) {
        gestureType.text = "探测到事件：Tap"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
```
 
运行程序，点击界面，就会将默认的 label 字样 修改成 **探测到事件：Tap**

done！


Tips：

 - 该demo源代码放在当前 **GestureTest** 目录下
 - 详细约束的创建、outlets的创建等，请参考[自适应布局](../basic/adaptive.md)文章


### 3.2、通过程序方式


使用 `[addGestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/#//apple_ref/occ/instm/UIView/addGestureRecognizer:)` 添加，核心代码类似于

```swift
let tapRecognizer = UITapGestureRecognizer(target:self , action: Selector("handleBackgroundTap:"));
tapRecognizer.cancelsTouchesInView = false
self.view.addGestureRecognizer(tapRecognizer)
```

由于Gesture是建立在 touch 事件基础上的，所以两者不能共存，因此 **如果需要手势识别，一定要将 `cancelsTouchesInViews` 设置成false**； 

本文章由于是属于基础部分，不会展开这种方式的demo，后续会在 action系列文章中 展示手势相关的代码程序；想进一步尝试的读者推荐参看以下文章：
 - [IOS-Swift开发基础——触控和手势](https://segmentfault.com/a/1190000004743547)：讲解了基础6种手势的用法
 - [UIGestureRecognizer Tutorial: Getting Started](https://www.raywenderlich.com/76020/using-uigesturerecognizer-with-swift-tutorial)
 - [UIGestureRecognizer in Swift](http://rshankar.com/uigesturerecognizer-in-swift/)