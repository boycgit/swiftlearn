# 滚动视图（Scroll View）

 - [UIScrollView 滾動視圖初學者指南](http://www.appcoda.com.tw/uiscrollview-introduction/)：各種UIScrollView的觀念、其中包括以程式建立一個滾動視圖與介面建構器（Interface Builder）、滾動（scrolling）與縮放（zooming）、以及巢狀滾動視圖（nested scroll views）
 - [UIScrollView Tutorial: Getting Started](https://www.raywenderlich.com/122139/uiscrollview-tutorial)：以ScrollView为展开点，讲解如何制作一个图像全屏展览，附带[中文译文](https://segmentfault.com/a/1190000003499357)
 

## 1、快速了解

创建滚动视图是很平常的需求，你图片、文本太多一页显示不下来，就需要让用户可以滚动阅读以能阅读所有的内容；

Scroll View是一个容器，它用于承载其他UIView视图组件作为子视图，这些子视图尺寸有可能比Scroll View大很多，具体图示如下：

![content](https://lh3.googleusercontent.com/-UUsI1ZjRT2k/V1d_eCfMHmI/AAAAAAAACwQ/KsrP_Kyp2XQLWbtFzlAL1U7lFxoGy_F0gCCo/s800/2016-06-08_09-41-38.png)

如上图所示，由Scroll View所接管的子视图的尺寸可以通过 `contentSize` 属性获取，该属性是 **CGSize** 类型（包含两个浮点型成员，`height` 和 `width`），因此获取内容尺寸的代码就是：
```swift
var contentHeight = scrollView.contentSize.height 
var contentWidth = scrollView.contentSize.width
```

在创建scroll view之初，内容尺寸大小和scroll view组件大小一致，所以是不能滚动的 —— 换言之，如果想要有滚动效果，需要编程 **动态设置contentSize属性**（在scroll view实例化之后），比如你在 `viewDidLoad` 中写：
```swift
scrollView.contentSize = CGSizeMake(320, 4200);
```

另外scroll view的重要属性是 `contentOffset`，该属性是 **CGPoint** 类型（包含两个浮点型成员，`x` 和 `y`），用于保存当前scroll偏离内容的距离，图示如下：

![offset](https://lh3.googleusercontent.com/-B1-0hp9CB1c/V1d_eLDavkI/AAAAAAAACwM/9YzWxnXcNjAhnan2YxVktU-fQUfZVk3NwCCo/s800/2016-06-08_09-50-04.png)

要在在滚动视图中添加内容（比如在视图之外），如果通过界面方式（IB）设置的话有些笨拙，建议通过程序的方式设置（会在其他章节中讲解）；

还有一个略坑的地方在于文本输入框，比如图中，用户想在 **Address (Line 1):**

![input](https://lh3.googleusercontent.com/-QbZt_lV-9rw/V1d_eIJrx-I/AAAAAAAACwU/kEprP1yHT3U7NaN1sxy9c4JCB2jb8wvogCCo/s800/2016-06-08_10-13-49.png)

输入地址的时候，弹出的键盘会遮住这个输入框，用户就看不到输入框的内容；一个解决方法就是，弹出键盘的时候，让scroll View的向上偏移一些即可（详见本文示例）：


## 2、示例

本节示例代码放在当前目录下 **ScrollingForms** 文件夹中，最终效果图：

![result](https://lh3.googleusercontent.com/-CHPzaNXfv0U/V2fmpzvLESI/AAAAAAAACx8/R7Rj9IkAd3Mx_nG9j6ncExsIjx5oXzU-ACCo/s800/scrollview.gif)

下面是较为详细步骤说明

**Tips**：
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)
 - 针对键盘事件的使用，请参考文档[用户输入及键盘的隐藏](./keyboard.md)


### A. 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **ScrollingForms**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）


### B. 添加UI元素

首先添加 UIScrollView 到界面上，并设置外观样式：
 - 不要勾选 **Constrain to margins** 选项
 - margin-left：0
 - margin-right：0
 - margin-bottom：0
 - margin-top：20

继续在滚动视图上添加 **5个Label** 和 **5个Input**，按照下表设置尺寸约束：

| 元素  | Left  | Top  | Width  | Height  |
|---|---|---|---|---|
| 用户名 (Label)  | 32  | 17  | 84  | 21  |
| 用户名 (Input)  | 32  | 8  | 256  | 30  |
| 密码 (Label)  | 32  | 38  | 81  | 21  |
| 密码 (Input)  | 32  | 8  | 256  | 30  |
| 地址1 (Label)  | 32  | 59  | 129  | 21  |
| 地址1 (Input)  | 32  | 8  | 256  | 30  |
| 地址2 (Label)  | 32  | 59  | 129  | 21  |
| 地址2 (Input)  | 32  | 8  | 256  | 30  |
| 邮编 (Label)  | 32  | 64  | 81  | 21  |
| 邮编 (Input)  | 32  | 8  | 256  | 30  |

更新视图之后，分别创建outlets变量名：`usernameField`, `passwordField`, `addressField1`, `addressField2` 以及 `postcodeField`.

![ui](https://lh3.googleusercontent.com/-EFrgIIcY9Gw/V2fpPcH9aRI/AAAAAAAACyQ/Dro6Xr7p-kQF1xXY-a-KsL2_zkTMVmQwgCCo/s640/2016-06-20_21-01-34.png)


接下来基本全是代码的活儿了

### C. 让ViewController实现 `UITextFieldDelegate` 协议

```swift
class ViewController: UIViewController, UITextFieldDelegate {
  ...
}
```
同时设置输入框相关的变量

```swift
var keyboardHeight:Float var currentTextField:UITextField!
```

最后将输入框的代理对象设置成当前ViewController

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        addressField1.delegate = self
        addressField2.delegate = self
        postcodeField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
```

### D. 绑定回调函数

当键盘出现或者消失的时候，需要让ViewController做出响应，注册两个回调函数`keyboardDidShow`和`keyboardDidHide`，分别响应`UIKeyboardDidShowNotification`和`UIKeyboardDidHideNotification`这两个键盘事件；

  - [x] 先在`viewWillAppear`中注册这些回调函数（这些回调函数这里先占位），注意这里的selector是经过优化的，详见[什么是Selector](../basic/selector.md)

```swift

private extension Selector {
    static let keyboardDidShow = #selector(ViewController.keyboardDidShow(_:))
    static let keyboardDidHide = #selector(ViewController.keyboardDidHide(_:))
}
...

class ViewController: UIViewController,UITextFieldDelegate{
    ....
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardDidShow, name: UIKeyboardDidShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardDidHide, name: UIKeyboardDidHideNotification, object: nil)
    }
    ...
}
```

   - [x] 之后在`viewDidDisappear`中解绑这些绑定

```swift
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIKeyboardDidShowNotification,object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIKeyboardDidHideNotification,object: nil)
        
    }
```

> 这里是挨个挨个解绑，如果觉得麻烦可以直接移除所有的回调：

```swift
override func viewDidDisappear(animated: Bool) {

super.viewDidDisappear(animated)

NSNotificationCenter.defaultCenter().removeObserver(self)

}
```
> 有关viewWillAppear的信息，可参看[iOS视图控制对象生命周期](http://my.oschina.net/jilin/blog/388414)

### E. 实现具体的回调函数

回调函数`keyboardDidShow`的定义如下：

```swift
    
    func keyboardDidShow(sender: NSNotification){
        
        // 获取键盘高度
        let info:NSDictionary = sender.userInfo!
        let value:NSValue = info.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardFrame:CGRect = value.CGRectValue()
        
        // 将CGFloat转换成Swift中的Float值
        let cgFloatKeyboardHeight:CGFloat = keyboardFrame.size.height
        keyboardHeight =  Float(cgFloatKeyboardHeight)
        
        // 确保当前text是可见的
        // 调整scroll视图中合适的offset距离
        let textFieldTop:Float = Float(currentTextField.frame.origin.y)
        let textFieldBottom:Float = textFieldTop + Float(currentTextField.frame.size.height)
        
        // 如果距离底部比键盘高，说明被键盘遮挡住了
        if(textFieldBottom > keyboardHeight){
            scrollView.setContentOffset(CGPointMake(0,CGFloat(textFieldBottom-keyboardHeight)), animated: true)
        }
        
        
    }
```

  - 存储键盘高度放在 `keyboardHeight` 变量中
  - 探测当前激活的输入框是否被键盘遮盖，如果被遮盖了，就更新scrollView的`contentOffset`属性

回调函数的`keyboardDidHide`就比较简单了，将 `contentOffset` 设置成（0，0）即可：

```swift
    func keyboardDidHide(sender:NSNotification){
        scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
    }
```

### F. 实现`UITextFieldDelegate`方法

需要实现这个协议中必要的方法：

 - [x] 实现`textFieldShouldReturn`方法，当用户点击回车按钮的时候隐藏键盘
```swift
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
```
 - [x] 实现`textFieldDidBeginEditing`方法，在用户点击输入框的时候会执行该片段，一方面它更新了`currentTextField`变量，另一方面和刚才 **keyboardDidShow** 函数做的事情一样，如果键盘被遮住了，就动态更新scrollView的`contentOffset`属性
```swift
    func textFieldDidBeginEditing(textField: UITextField) {
        currentTextField = textField
        let textFieldTop:Float = Float(currentTextField.frame.origin.y)
        let textFieldBottom:Float = textFieldTop + Float(currentTextField.frame.size.height)
        if textFieldBottom > keyboardHeight && keyboardHeight != 0.0 { scrollView.setContentOffset(CGPointMake(0, CGFloat(textFieldBottom - keyboardHeight)), animated: true) }
    }
```

Well Done，运行模拟器就能查看到效果了