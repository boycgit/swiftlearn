# 通过picker设置数据

参考文章：
 - [iOS8 PickerView控件-Swift教程](http://www.swiftmi.com/topic/119.html)：基本入门教程，是从 **ioscreator** 系列教程《[Picker View Tutorial in iOS8 with Swift](http://www.ioscreator.com/tutorials/picker-view-tutorial-ios8-swift)》翻译过来的

## 1、简要说明

picker view组件通过滚轮界面提供单项或多值选项，一个PickView可以由多个“轮子”（component）组成， 每个轮子又由多行内容元素构成；看一看Date Picker就能理解了：

![multi picker](https://lh3.googleusercontent.com/-EQLvRUkIArw/Vz0vA1KplhI/AAAAAAAACqM/xEuAcVSCUUcJXWahC1FyNI9zr85CorpRgCCo/s800/2016-05-19_11-11-41.png)


该组件对应的类名 `UIPickerView` ，属于 UIKit 框架库，构造picker需要 **数据源（data source）对象** 和  **委托（delegate）对象** ；

 - 数据源对象：该对象实现 `UIPickerViewDataSource` 协议，并提供轮子数量、每个轮子多少行等信息
 - 委托对象：该对象实现 `UIPickerViewDelegate` 协议，可以设置每个条目的内容等，也提供一个回调，当轮子转动改变值时会调用

这两个对象 **可以是同一个** ，而且一般情况下 **都是由viewController对象承担** —— 当然，你不想怎么做也是可以的；

根据上面的说明，我们要创建一个Pick View其实很简单，从组件库拖拽到storyboard上，然后创建一个连接到view controller的outlets即可；

## 2、创建数据源对象、委托对象

有两种方式创建建数据源对象和委托对象。

 - 通过UI拖拽方式：

![by drag](https://lh3.googleusercontent.com/-IKxPTyUYV8o/Vz0yOFUgoSI/AAAAAAAACqY/YYsjEtFajK4pV51t0A92ZB0tI2NhEE-rACCo/s800/13_1413733769591_661.png)

 - 通过程序方式：（这里的pickView是组件的outlets）

```swift
override func viewDidLoad() {

    super.viewDidLoad()
    
    pickerView.delegate = self 
    pickerView.dataSource = self
}
```


创建完成之后，还需要实现对应协议的方法。

### 2.1、实现数据源协议

查阅API文档，可知数据源对象对应的协议 `UIPickerViewDataSource` 定义了两个方法：
```swift
func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int

func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
```

前一个指定轮子的个数，后面一个指定每个轮子上条目的个数：

```swift
// returns the number of 'columns' to display. 
func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {

  return 2 

}

// returns the # of rows in each component.. 
func pickerView(pickerView: UIPickerView,
    numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {

      return cities.count 
      
    } else {

      return placesOfInterest.count 
      
    }

}
```


### 2.2、实现委托协议

委托协议是用来设置每个条目的内容和回调函数的；

**每个条目所要显示的内容**，需要实现方法：
```swift
func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!

```

当用户选中了任何一个轮子上的条目，都会执行方法：
```swift
func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
```

一般来讲，我们会把要呈现发数据存在数据里，比如我们将城市存放在数组变量 **cities** 中，将场所存放在数组变量 **placesOfInterest** 中，这两个变量赋值到两个轮子上的过程如下：

```swift
var cities = ["New York","London","Paris","Chicago"] 
var placesOfInterest = ["Hotels","Cinemas","Theaters","Airports","Museums","Clubs"] 
func pickerView(pickerView: UIPickerView, 
  titleForRow row: Int, 
  forComponent component: Int) -> String! { 
      if component == 0 {
    
        return cities[row]
      
      } else {
      
        return placesOfInterest[row] 
      }
}
```



## 3、Date Picker（时间选择器）

因为选择日期是非常常用的一项功能，因此苹果公司干脆就定制pick view，提供现成的时间选择器，提供配置项，可以展现成日期、时间等模式。

这种日期选择器对应 `UIDatePicker` 类，该类内部调用一个 `UIPickerView` 实例，只是用户并不能直接获取该实例；

相比起 view picker，日期选择器更加容易使用，你直接将其拖拽到界面上就能使用，不需要提供数据源和委托对象；还能通过属性编辑器直接编辑组件的属性：

![date picker](https://lh3.googleusercontent.com/-aPMivRvPfus/Vz1GRLEs9TI/AAAAAAAACqo/8MFbwmXQMFEIX0zaXWzuJoqsi-5Fc7ZnACCo/s800/2016-05-19_12-50-40.png)

用户可以直接通过`date`属性读取选择器当前的日期内容，返回类型是 `NSDate`：

```swift
// get date from date picker 
var pickerDate:NSDate! = datePicker.date
```
> 更多有关 NSDate 的知识，添加阅读 [这是一篇写给新手的NSDate教程（Swift版）](http://www.cocoachina.com/swift/20151126/14430.html)：写给新手的NSDate教程


对应的，当选择器变化的时候，会触发 **Value Changed** 事件，用户可以在辅助编辑器中创建该事件的Action来响应；

## 4、自定义picker - demo

### 4.1、预览
picker除了展现文本之外，还可以展现图片（当前 文字+图片 也是可以有的），在本小节中我们就创建一个demo，通过 **UIView** 子类定制一个图片picker，最后的结果展现如下：

![fruit map](https://lh3.googleusercontent.com/-IJkl6VU5vxw/Vz1nB_O1__I/AAAAAAAACq4/2vTf5EuMWHcKlh7EUF85XzU82D4oXqrCgCCo/s800/fruitmap.gif)

关键就是实现委托对象是三个方法：

```swift
func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat

func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat

func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
```

 - **pickerView(pickerView, widthForComponent)** ：用于指定每个轮子的宽度，默认是宽度等分；即3个轮子，那每个轮子占33%宽度；
 - **pickerView(pickerView, rowHeightForComponent)** ：指定每个条目的高度，每个轮子里的条目高度是一样的
 - **pickerView(pickerView, viewForRow, forComponent, reusingView)** ：返回 **UIView** 子类，这些子类可以是现有的UIKit提供的现成类（比如 UIImageView 或者 UILabel等），也可以是自己实现的（当然，这块内容本节不涉及到，放在其他高阶章节里）；注意最后一个参数 **reusingView** 是指我们可以复用该行的视图元素，比如当我们滚轮上的元素滚出我们的视图之外，picker并不会立即将其销毁，而是存放在缓存中，当该元素需要重新在当前轮子中展现出该元素的时候就可以快速显示出来，提高性能；


> 本节代码放在目录 **CustomPickerTest** 中，所需要的图片素材也在改目录下的 **images** 文件夹中

**Tips**：
 - 手势识别内容，请移步[Responder 及 Touches事件](./touch.md)
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)


### 4.2、详细步骤

#### A. 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **CustomPickerTest**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）



#### B. 添加静态资源

点击 **Assets.xcassets** ，创建若干个Image Set，名字分别为 `bananaImages`, `lemonImages`, `orangeImages`, `peachImages`, `pearImages`, 和 `pineappleImages`；

然后将目录中的图片挨个拖拽到对应的图片集中就行了：
![image set](https://lh3.googleusercontent.com/-hYZeyOxGiMo/Vz6ymv8xEmI/AAAAAAAACrk/po2yoaoY5L8RQRCDandKhK6JYTOs6FYFQCCo/s800/2016-05-20_14-12-01.png)


#### C. 创建UIPickerView实例

点击 **MainStoryboard.storyboard** 文件，然后拖拽 Pick View 组件到画布上；设置一下这个组件的尺寸和位置：
  - 水平居中
  - 高度162，距离顶部0

然后打开辅助编辑器，拖拽创建outlets对象，名为 **pickerView**

接着需要绑定数据源和委托对象啦，也很简单：
 1. Ctrl+单击 该组件
 2. 在弹出的快捷菜单中分别拖拽 **delegate** 和 **dataSource** 到当前 view controller，注意是两个哦

过程图如下：
 ![link](https://lh3.googleusercontent.com/-sDpql3QASXQ/Vz6yw_1UUVI/AAAAAAAACrg/UZiJ0PpZqBQ0qEOYNbyw02f7SccDzzheACCo/s800/2016-05-19_14-36-20.png)
 
#### D. 添加UILabel实例
 
接下来我们放置一个label来展现用户操作的结果。
 
从组件库里拖拽一个label组件放到画布上，设置大小和位置：
  - 按住 "Cmd+=" 快捷键，让组件宽度自适应文本
  - 设置水平居中
  - 设置margin top 值为32

然后打开辅助编辑器，创建outlets对象，名为 **resultsLabel**

#### E. 代码赋能

接下来就是一大波的程序代码了，请保持战斗力；

创建 `dataForComponent1`, `dataForComponent2` 和 `dataForComponent3` 这3个变量用于存放3个轮子里的内容：
```swift
    let dataForComponent1:[String] = ["Apple", "Banana", "Lemon", "Orange", "Peach", "Pear", "Pineapple"]
    let dataForComponent2:[String] = ["Banana", "Orange", "Pear", "Apple", "Pineapple", "Lemon", "Peach"]
    let dataForComponent3:[String] = ["Pear", "Peach", "Lemon", "Pineapple", "Apple", "Banana", "Orange"]
```

创建 `nameToImageMapping` map变量，将文字和图片关联起来：
```swift
    let nameToImageMapping:[String:String] = [
        "Apple":"appleImages",
        "Banana":"bananaImages",
        "Lemon":"lemonImages",
        "Orange":"orangeImages",
        "Peach":"peachImages",
        "Pear":"pearImages",
        "Pineapple":"pineappleImages"
    ]
```

初始化label的内容，在 **viewDidload** 方法中初始化label：
```swift
 resultsLabel.text = "请匹配每一行的水果";
```

有原材料了，接下来我们来实现数据源和委托对象的协议啦；

首先声明view controller要实现 `UIPickerViewDataSource` 和 `UIPickerViewDelegate` 协议：

```swift
...
class ViewController: UIViewController,
            UIPickerViewDataSource,
            UIPickerViewDelegate{
              ...
            }
```
![impliment](https://lh3.googleusercontent.com/-o0UcItgiH0s/Vz6ymgzysHI/AAAAAAAACrc/I6s59yn30CoS1JwFfoC_h-WW8dbFu2ikACCo/s800/2016-05-20_14-28-17.png)


声明之后就要遵守协议规范，依次实现所需要的协议内容，分别有：

 - [x] 实现 **numberOfComponentsInPickerView()** ，设置轮子个数为3个：
 
```swift
    func numberOfComponentsInPickerView(pickerView:UIPickerView) -> Int{
        return 3;
    }
```

 - [x] 实现 **pickerView(pickerView, numberOfRowsInComponent)** ，设置每个轮子上的条目数量

```swift
    func pickerView(pickerView:UIPickerView,numberOfRowsInComponent component:Int) -> Int{
        if component == 0{
            return dataForComponent1.count
        } else if component == 1{
            return dataForComponent2.count
        } else {
            return dataForComponent3.count
        }
    }
    
```

 - [x] 实现 **pickerView(pickerView, rowHeightForComponent)** ，设置每个条目的高度为50

```swift
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
```

 - [x] 实现 **pickerView(pickerViewm viewForRow, forComponent, reusingView)**，设置每个条目的内容是 UIImageView，使用reusingView选项，能够复用view组件；（如果不存在就创建，存在旧view就替换里面的内容）
 
```swift
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        // 获取水果名字
        var keyString:String? = nil
        
        if component == 0{
            keyString = dataForComponent1[row]
        } else if component == 1 {
            keyString = dataForComponent2[row]
        } else {
            keyString = dataForComponent3[row]
        }
        
        let imageFileName:String? = nameToImageMapping[keyString!];
        
        if view == nil{
            return UIImageView(image:UIImage(named:imageFileName!))
        }
        
        let imageView:UIImageView = view as! UIImageView
        imageView.image = UIImage(named:imageFileName!)
        
        return imageView
    }
```

 - [x] 最后实现 **pickerView:didSelectRow:inComponent**，用于响应用户更改轮子的操作，当3个轮子里的内容一致的时候就在label中显示祝贺词：
 
```swift
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 获取每个轮子中选中的水果
        let selected1 = pickerView.selectedRowInComponent(0)
        let fruit1:String! = dataForComponent1[selected1]
        
        let selected2 = pickerView.selectedRowInComponent(1)
        let fruit2:String! = dataForComponent2[selected2]
        
        let selected3 = pickerView.selectedRowInComponent(2)
        let fruit3:String! = dataForComponent3[selected3]
        
        if fruit1 == fruit2 && fruit2 == fruit3{
            resultsLabel.text = "匹配成功！"
        } else {
            resultsLabel.text = "请匹配每一行的水果"
        }
    }
```

好了，well done，点击运行让你的程序跑起来吧~


