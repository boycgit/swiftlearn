# 闭包

闭包是比较重要的概念，在各种语言中也多有体现，比如Java中的 **lamda** 表达式，而在JS中也有“闭包”概念；这些概念也是基本想通的，有其他语言基础的同学学习起来会比较轻松；

抛开语法和作用域层面的理解，闭包可以认为是函数的“简洁版”；我们下面也将从这个角度，帮大伙儿初步理解Swift中闭包；


## 函数是“一等公民”

Swift 博采众长，当脚本使用也是非常舒适的，因此用过 JavaScript 和 ActionScript 的程序员看Swift代码会有一种熟悉感；

和JS一样，函数在Swift中也属于一等公民 —— 你可以将函数当做变量、返回值、形参等等，从而形成各种高级的使用方式；

其实，**函数是属于闭包的一种**；

## 闭包

广义上来讲，有3种类型的闭包
 
  - 全局闭包：就是普通的函数，使用关键字 **func** 定义
  - 内置闭包：就是局部函数了，在函数体内再用 **func** 定义的函数就是这种，也比较好理解
  - 闭包表达式：平常我们提到 **闭包** 默认就是指这种

闭包（除非特殊说明，否则默认是指闭包表达式）的语法为：

```swift
{
    (params) -> return type in
    statements
}
```

也就是说，闭包的特征就是以 **大括号{}** 为标志，里面还有关键字 `in`。你可以将闭包看比如像字符串这样的字面量或变量，可一样赋给其他变量：

```swift
var cubeNumber : (Int) -> Int = {
    (inputValue : Int) -> Int in
    return inputValue * inputValue * inputValue
}
```

这里我们将闭包赋给 `cubeNumber` 变量，那么此时 `cubeNumber` 就是一个 **函数变量** ，具有立方数计算功能；
> 闭包的 **形参声明(inputValue : Int)** 和 **返回值声明 Int** 都是在 关键字 `in` 之前

仔细观察，我们会发现闭包中的形参声明和返回值声明是和 `cuberNumber` 的类型声明想对应的，因此我们能省略闭包中的 **类型声明** ，Swift能推断出类型，最终获得常见的闭包样子：

```swift
var cubeNumber : (Int) -> Int = {
    inputValue in
    return inputValue * inputValue * inputValue
}
```
