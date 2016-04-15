# 错误处理

WWDC 2015 宣布了新的 Swift 2.0. 这次重大更新给 Swift 提供了新的异常处理方法。

参考文章：

 - [Swift 2.0 异常处理](http://www.swiftmi.com/topic/313.html)


在新的 Swift 2.0 中，我们可以使用新的 `ErrorType protocol` 

## 异常类
在swift 2.0 中， 如果想建立属于你自己的异常类型，那么 **enum** 无疑是最好的方法；你只要在你的 **enum** 中确认新的 **ErrorType**。 我们身处的网络是比较不稳定的，偶尔断网，偶尔服务器500错误，或者请求超时什么的，用它来作为异常示例最好不过。

我们定义一个 **NetworkError** 类囊括场景的网络错误：

```swift
enum NetworkError: ErrorType{
    case ResourceNotFound   // 资源请求不到
    case ServerError(httpErrorCode:Int)  // 服务器内部错误
    case NetworkTimeout  // 链接超时
}
```


## throw

在抛出异常之前，我们需要在函数或方法的返回箭头 `->` 前使用 `throws` 来标明将会抛出异常；

比如我们声明一个下载图像的函数：

```swift
func downloadImg(resourceName: String) throws -> NSData?{

  guard resourceName.isEmpty else {
    throw NetworkError.ResourceNotFound
  }
  return nil
}
```

Swift中的声明可以说有些刻板，从throw的用法可以看出；没有标记过 `throw` 的代码不能抛出 **运行时错误** ，只有标记过的方才有资格抛 —— 当然，刻板从另外一个角度理解，则是“规范”，大家都遵守了这些规范，会提高代码阅读的效率；

除了声明比较刻板之外，使用标有 `throw` 的函数也很刻板，必须要在前面加关键字 `try`，不try不行啊，编译不通过的啊：

```swift
let homeScreenBanner:NSData? = try downloadImg("homeScreenBanner.png")
```

你以为单单 try 就可以了？！ 

上面代码如果发生错误了，你是捕捉不到错误信息的；怎么办？来来来，配套上 `do...try...catch`：

```swift
do {
    let homeScreenBanner:NSData? = try downloadImg("homeScreenBanner.png") 
} 
catch (NetworkError.NetworkTimeout) { 
    print("Network error occurred!") 
} catch {
    print("Some other error occurred!") 
}
```
> 最后一个catch语句相当于 switch 中 `default`，处理一切未知错误的功效

有没有一种 **买了手机必须要买贴膜，否则没有安全感** 的感觉？

这还不算，上面那段代码你有可能封装到一个函数里，比如这个函数就叫 **loadHomeScreenImages**，如果你这么包装一下，是没有问题的：

```swift
func loadHomeScreenImages() {
    do {
        let homeScreenBanner:NSData? = try downloadImg("homeScreenBanner.png") 
    } 
    catch (NetworkError.NetworkTimeout) { 
        print("Network error occurred!") 
    } catch {
        print("Some other error occurred!") 
    }
}
```

若是你把最后的 catch 保底方案去了：
```swift
func loadHomeScreenImages() {
    do {
        let homeScreenBanner:NSData? = try downloadImg("homeScreenBanner.png") 
    } 
    catch (NetworkError.NetworkTimeout) { 
        print("Network error occurred!") 
    }
}
```

编译器会送一个大红叉：
```shell
 errors thrown from here are not handled because the enclosing catch is not exhaustive
```
![error](http://ww1.sinaimg.cn/large/514b710agw1f2xd3ltoccj20fw0bqdi3.jpg)

翻译成通俗一点的意思，就是说 **你没有做好万全的catch工作，万一遇到其他错误就会引起程序崩溃的，所以老子不让你编译通过的**

为何我的眼中常常含泪水~~因为子子孙孙无穷匮也~~ 

解决方法无外乎两种：
 - 一种就是添加回 catch 语句
 - 另一种就是把这黑锅甩给外面的程序；

赶紧告诉我怎么甩锅？！

添加`throws`（别忘了`s`后缀！）关键即可
```swift
func loadHomeScreenImages() throws {
    ...
}
```

> 如果程序员比较任性，**不想处理异常怎么办**？，或者 **程序员对自己超有自信**，非常确定某个方法或者函数虽然声明会抛出异常，但是在自己使用时候是绝对不会抛出任何异常的，怎么办？
> 
> 这种情况下，可以使用 `try!`，比如 `try! functionThrowErrorNil()`；你得做好准备，因为很有可能程序在运行过程中会获得一个运行中异常 (runtime error) ；
> 
> 额...一般，老板其实并不喜欢任性的程序员；所以，这个`try!`要慎用！
 
甩锅的过程先讲到这里，最后，我们讲些和错误处理相关的最佳实践；

## Guard

`guard` 翻译过来可以理解为守护，守卫；它属于 swift 的关键字；

初学者有可能不知道这个单词是几个意思；其实它的意思并不难，就是 **强条件的if**，所以陌生的同学在使用的时候可以将其视为 `if`，方便记忆理解。

`guard` 和 `if` 有两个非常重要的区别：
 - `guard` 必须强制有 `else` 语句
 - 只有在 `guard` 审查的条件成立，guard 之后的代码才会运行 (像守卫一样，条件不符就不让过去)

> 你一但声明 `guard`， 编译器会强制要求你和 `return`, `break` 或者 `continue` 一起搭配使用，否则会产生一个编译时的错误。

之所以这么做，写过容错代码的人会知道，比如我们从接口里取了某个对象，一般会先确保这个对象存在，然后再去访问这个对象的属性；代码一般会长这个样子：

```swift
if obj {
    // 在这里访问 obj.xxx 属性
} else {
    return
}
```

不过在swift中，而是推荐用这种方式：

```swift
guard obj else {
    return
}
// 在这里访问 obj.xxx 属性，因为经过“门卫”审查之后，这个对象是安全的
```
这也属于swift编程风格的[最佳实践](https://github.com/Artwalk/swift-style-guide/blob/41bf5bb39ec28e434c39f5dcb26e090867aecb4e/README_CN.md)中的 **尽早地 Return 或者 break** 的原则；

guard 中的 else 只能执行转换语句，像 `return`, `break`, `continue` 或者 `throws` ；当然你也可以在这里返后一个函数或者方法。

得注意的是，guard的使用会提高你代码的可读性，但是也代表你的代码的执行会有 **非常明确的顺序性**，这一点需要开发者们留心处理。

## defer

如果你使用了 `defer` 。在你的代码块结束前，defer 之中的代码就会运行。等于说，给了你最后的机会来进行一些处理。

我们把上述的 `downloadImg` 方法修改如下：

```swift
func downloadImg(resourceName: String) throws -> NSData?{

    guard resourceName.isEmpty else {
        defer{
            print("one")
        }
        
        defer{
            print("two")
        }
        
        throw NetworkError.ResourceNotFound
        
        defer{
            print("three")
        }
    }

    return nil
}
```

出错的时候，打印出的结果：
```shell
 two
 one
```

 - 没有打印出 `three`
 - 先打印 `two` ，再打印 `one`，因此多个defer语句执行的顺序会和 **栈** 一样，**最后一个进，第一个出**

defer执行的机制是在程序 **退出当前程序块** 的时候执行的，所以在这个语句中，切莫使用 `break` 、`return` 或者 **重新抛出错误** 等作死行为；（用了这些语句，好比打了败仗大伙儿集体后撤，你却单枪匹马往前冲，那不是作死是什么？）