# Cocoa框架

 - [FOUNDATION 框架 ](http://swifter.tips/foundation-framework/)：Swift 的基本类型都可以无缝转换到 Foundation 框架中的对应类型。
 - [IOS 整体框架类图–值得收藏](http://www.swift.ren/?p=146)：真的很全，从全局上讲解了基本的类库框架结构
 - [概述：Swift与Foundation框架](http://www.69900.com.cn/ZaoAnwife/article/details/50637365):系列文章
 - [The Foundation Framework](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/ObjC_classic/index.html#//apple_ref/doc/uid/20001091)：权威的官方框架组织结构图，这里包含一切你想要的东西，擅用 Ctrl+F 查找

我们通常称为的 **Cocoa框架** ，事实上Cocoa本身是一个框架的 **集合**，它包含了众多子框架，其中最重要的要数 **Foundation** 和 **UIKit**：
 - Foundation : 是框架的基础，和界面无关，其中包含了大量常用的API；
 - UIKit：是基础的UI类库，以后我们在IOS开发中会经常用到

这两个框架在系统中的位置如下图：

![pos](http://ww1.sinaimg.cn/large/514b710agw1f2ypiso9sbj20dv0560t6.jpg)


我们可以将 **Cocoa框架** 理解成工具箱，如果不用这个工具箱的话，很多东西都要自己制造，一是稳定性不够，二是也没有必要；（你要当厨师的话，菜完全可以去买，不必自个儿去种！）

## Swift中的兼容性

为了方便使用，Swift 的基本类型都可以 **无缝转换** 到 Foundation 框架中的对应类型。脱离 Cocoa 框架进行 app 开发是不可能的事情。因此我们在使用 Swift 开发 app 时无法避免地需要在 Swift 类型和 Foundation 类型间进行转换。如果需要每次显式地书写转换的话，大概就没人会喜欢用 Swift 了。还好 Swift 与 Foundation 之间的类型转换是可以自动完成的，这使得通过 Swift 使用 Cocoa 时顺畅了很多。

这个转换不仅是自动的，而且是双向的，而且无论何时只要有可能，**转换的结果会更倾向于使用 Swift 类型**。也就是说，只要你不写明类型是需要 NS 开头的类型的时候，你都会得到一个 Swift 类型。

```shell
String - NSString
Int, Float, Double, Bool 以及其他与数字有关的类型 - NSNumber
Array - NSArray
Dictionary - NSDictionary
```

举个例子：

```swift
import Foundation

let string = "/var/controller_driver/secret_photo.png"
let components = string.pathComponents
```

string 在 Swift 中是被推断为 **String** 类型的，但是由于我们写了 `import Foundation`，因此我们可以直接调用到 NSString 的实例方法 **pathComponents** 。

`pathComponents` 返回的应该是一个 **NSArray** ，但是如果我们检查这里的 components 的类型 (使用 `components.dynamicType`)，会发现它是一个 **[String]**。在整个过程中我们没有写任何类型转换的代码，一切都这么静悄悄地就发生了。

如果我们出于某种原因，确实需要 **NSString** 以及 **NSArray** 的话，我们需要显式的转换：
```swift
import Foundation

let string = "/var/controller_driver/secret_photo.png"

let components_ = string.pathComponents as NSArray
let fileName_ = components_.lastObject as! NSString

components_.dynamicType //_SwiftDeferredNSArray.Type
fileName_.dynamicType   //__NSCFString.Type
```
> 一般情况下当然是不需要这么多此一举的。


有一个需要注意的问题是 Array 和 Dictionary 在行为上和它们对应的 NS 模式的对应版本有些许不同。因为 Swift 的容器类型是 **可以装任意其他类型的**，包括各种 **enum** 和 **struct** ，而 **NSArray 和 NSDictionary 只能放 NSObject 的子类对象**。所以在 Array 和 Dictionary 中如果装有非 AnyObject 或者不能转为 AnyObject 的内容的话，做强制的转换将会抛出编译错误 (这要感谢 Swift 的强类型特性，我们可以 **在编译的时候就抓到这样的错误**)。
