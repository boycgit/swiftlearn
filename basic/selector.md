# selector

 - [What is a selector?](https://www.hackingwithswift.com/example-code/language/what-is-a-selector)：简短有效的解释
 - [Swift：Selector 语法糖](http://swift.gg/2016/06/02/swift-selector-syntax-sugar/)：在swift2.2中，可以优化selector的写法，推荐；
 - [SELECTOR](http://swifter.tips/selector/):陈列了Selector在Obj-C 和 Swift中的差别

前端领域中的selector是指CSS选择器，不过在iOS开发中，selector则更像JS中的回调函数概念：

**Selector是object或者struct中的方法名，用于在程序运行时执行的调用（回调）**；

很明显在 **观察者模式（target/action）** 中使用selector比较多，比如在`NSTimer`或者`UIBarButtonItem`中；举例来讲，当你创建一个按钮，用户点击这个按钮（target）的时候，就会执行绑定的selector程序（action）；

## 在swift中的使用

@selector 是 Objective-C 时代的一个关键字，在 Swift 中没有 @selector 了，取而代之，从 Swift 2.2 开始我们使用 `#selector` 来从暴露给 Objective-C 的代码中获取一个 selector;

通常的写法如下：

```swift
func callMe() {
    //...
}

func callMeWithParam(obj: AnyObject!) {
    //...
}

let someMethod = #selector(callMe)
let anotherMethod = #selector(callMeWithParam(_:))
```

记得在 callMeWithParam 后面加上冒号 (:)，这才是完整的方法名字；多个参数的方法名也和原来类似，是这个样子：

```swift
func turnByAngle(theAngle: Int, speed: Float) {
    //...
}

let method = #selector(turnByAngle(_:speed:))
```

最后，值得一提的是，如果方法名字在方法所在域内是唯一的话，我们可以简单地只是用方法的名字来作为 #selector 的内容。相比于前面带有冒号的完整的形式来说，这么写起来会方便一些：

```swift
let someMethod = #selector(callMe)
let anotherMethod = #selector(callMeWithParam)
let method = #selector(turnByAngle)
```

但是，如果在同一个作用域中存在同样名字的两个方法，即使它们的函数签名不相同，Swift 编译器也不允许编译通过：

```swift
func commonFunc() {

}

func commonFunc(input: Int) -> Int {
    return input
}

let method = #selector(commonFunc)
// 编译错误，`commonFunc` 有歧义
```

对于这种问题，我们可以通过将方法进行强制转换来使用：

```swift
let method1 = #selector(commonFunc as ()->())
let method2 = #selector(commonFunc as Int->Int)
```


## 最佳实践

### 正确的命名

好的事件函数命名方法：**对象名作为前缀，动作作为后缀**。比如按钮（button）点击（tapped）事件命名为 `buttonTapped:`。此外，确保每次都给 sender 传入正确的类型参数。**即使不需要这个参数，你也最好把它传进去**，万一要用到呢。

下面是我推荐的事件函数命名：

```swift
func segmentedControlValueChanged(sender: UISegmentedControl) { }
func barButtonItemTapped(sender: UIBarButtonItem) { }
func keyboardWillShowNotification(notification: NSNotification) { }
```

### 优化写法

在 Swift 2.2 中，selector 的写法更加安全了，但是还是很丑。
```swift
button.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), forControlEvents: .TouchUpInside)
```

在浏览代码的时候，上面这句代码简直不忍直视，太长，可读性也很差。再脑补下你还要在很多地方使用它（复制粘贴…）。

让我们来整合一下这些 selector，这样需要时可以直接引用，**并且可以在同一个地方修改**。

```swift
private struct Action {
    static let buttonTapped = 
        #selector(ViewController.buttonTapped(_:))
}
...
button.addTarget(self, action: Action.buttonTapped,       
    forControlEvents: .TouchUpInside)
```
 - 现在我们可以在 **同一个地方** 定义这些 selector。
 - 任何一个想要使用 `selector` 的对象都可以直接从 `Action` 结构体取出静态常量。
 - 结构体声明为 **private** 是为了防止 Xcode 报声明冲突错误，这个结构体 **只能用于当前 .swift 文件**。

上面的写法还有一个缺点，我们不得不将这个结构体命名为 Action，因为 Selector 这个更好的名字已经被 `Selector` 占用了。

这种模式还能再优化一下，还能更优雅。既然能用 Selector extension，为什么还要用 Action 结构体呢？

```swift
private extension Selector {
    static let buttonTapped = 
        #selector(ViewController.buttonTapped(_:))
}
...
button.addTarget(self, action: .buttonTapped, 
    forControlEvents: .TouchUpInside)
```

简直完美！我们给 `Selector` 加了一个 **extension** ，它包含了我们想要调用的 selector 的静态常量。

这样还可以利用 Swift 的 **类型推断**。对象的 `action:` 参数需要 Selector 类型，我们使用的就是 `Selector` 的属性，因此可以省略 `Selector`. 前缀（之前 Action 必须写成 `Action.buttonTapped`）。

就像你要给 view 设置颜色时候，省略掉 `UIColor.` 一样：
```swift
view.backgroundColor = .blackColor()
```

具体的可以参考[示例代码](https://github.com/andyyhope/Blog_SelectorSyntaxSugar/blob/master/Blog_SelectorSyntaxSugar/ViewController.swift)