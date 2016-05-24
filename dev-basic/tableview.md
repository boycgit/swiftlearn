# Table View介绍

## 1、基本介绍
表格视图（Table View）组件继承自 **UITableView** 对象，属于 **UIKit** 框架的一部分；

tableview以一列的方式展现数据，每个元素都是放在 **UITableViewCell** 对象中；table view自己封装了一套优化代码，当元素超过一屏之后，滚动的时候能重用现有的单元格对象；

数据在tableview以 **section（节）** 作为组织单元，section的编号从0开始递增；每个section都有可选的头（header）和尾（footer），默认展现的table只有 **一节**，且不带头尾；

section里的每个单元格（cell）也都是从0开始递增标号；

另外，tableview的展现方式分为两种：plain 或者 grouped，前者展现成连续列表，后者在每节之间会有空闲；

![plain](https://lh3.googleusercontent.com/-na4mIf2rDiM/V0O-SRYYpBI/AAAAAAAACsU/isnVE1bdUqMbzdW73YShlR6MVeUf3q8HACCo/s800/2016-05-24_10-36-34.png)

![plain](https://lh3.googleusercontent.com/-Cxg4TrlZ75c/V0O_agc_z3I/AAAAAAAACso/V982LCgm_0IZT0NoK0oOlfAlLtSUPIp9ACCo/s800/2016-05-24_10-41-27.png)
（左边是plain，右边是grouped）


## 2、数据展现类型

tableview可以展现静态数据（static content）或者动态数据（dynamic content）

### 2.1、静态数据

静态数据在你设计期间能够硬编码配置，有多少行、每行内容是什么都直接配置好，到时候直接展示出来就行；

首先你去属性监视器中设置 **Content** 属性为 **Static Cells**：


然后在文档大纲中点击相应的section，然后在属性监视器中进行编辑即可：

![static](https://lh3.googleusercontent.com/-fBiH33Cfev4/V0O-SQSbXlI/AAAAAAAACsY/bGNVBtfijHQHBqUIecuWeLiDHAaXfLwDQCCo/s800/2016-05-24_10-35-33.png)

每个单元格（cell）中你可以继续拖拽其他标准的组件，比如label、image view等等，然后需要挨个设置每个单元格内容的尺寸约束


若布局不复杂，推荐用系统提供的布局方式，属性监视器中的 **cell style** 提供了四种默认的选项：
 - Basic
 - Rigth Detail
 - Left Detail
 - Subtitle

选择之后可能会添加额外的label组件，你双击之就能编辑对应的内容了：

![edit](https://lh3.googleusercontent.com/-kga0By3uLDI/V0O-SamDv1I/AAAAAAAACsc/AK1LBqZEQmMnBJPs9snN-0x_vc2LuPluQCCo/s800/2016-05-24_10-35-56.png)

### 2.2、动态数据

设置动态数据会稍微复杂，但灵活性很大，是一种必须要掌握的技能；

在使用动态数据时，首先你得设置一个单元格模板（template cell），在程序中称为 **prototype cell** ，程序运行的时候你就将数据塞到这些个模板中，就能生成所需要的视图了；

当然你可以使用多种单元格模板，不过平时最常用的还是单个模板形式，只是内容不一样；使用模板个数，需要在监视器中进行设置：

针对每个单元格模板，需要在ID监视器中设置ID属性，

默认情况下，单元格模板继承自 **UITableViewCell. UITableViewCell** 类，该类包含一个imageview 和 label组件，可分别通过 **imageView** 或者 **textLabel** 获取引用；

如果自己对默认的单元格模板不太中意，自己写一个 **UITableViewCell** 的子类，然后在ID监视器中关联上即可；

为了在当前view controller中使用动态tableview，需要实现 **UITableViewDataSource** 和 **UITableViewDelegate** 中的协议方法，和[通过picker设置数据](./picker.md)非常类似；一般来讲会将数据源对象和委托对象都设置成 **当前View Controller** 对象，然后让view controller实现协议所需要的方法；


**UITableViewDataSource** 需要实现的方法：

```swift
func numberOfSectionsInTableView(tableView: UITableView) -> Int

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
```

 - 第一个方法设置有几节
 - 第二个方法设置每一节有多少个单元格（cell）
 - 第三个方法设置每个单元格的具体内容

**UITableViewDelegate** 需要实现的方法：

```swift
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
```
该方法是用户选择单元格时的回调函数；如果你在 storyboard 中设置一个 **segue** 从当前tableview到另一个场景中，则不会调用该方法，而是调用 **prepareForSegue** 方法，执行跳转逻辑；

下面的代码片段是实现两个协议的典型范例：

```swift
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var fruits:Array<String> = ["Apple", "Banana", "Mango", "Pear", "Peach", "Plum", "Grape", "Melon", "Orange"]
  
  override func viewDidLoad() {
  
      super.viewDidLoad() 
  }

  override func didReceiveMemoryWarning() {
  
      super.didReceiveMemoryWarning() 
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
  
    return 1 
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
    return fruits.count 
  }
  
  func tableView(tableView: UITableView,
      cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellPrototype1",forIndexPath: indexPath)
        cell.textLabel?.text = fruits[indexPath.row] 
        return cell 
  }

}
```

> 在swift2.0之前，对`cellforRowAtIndexPath`的实现方法是

```swift
 var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellPrototype1") as! UITableViewCell
```
> 这个拆包语句在最新的xcode中会报错，**Downcast from 'UITableViewCell?' to 'UITableViewCell' only unwraps optionals; did you mean to use '!'?** ，修改成上述的方式即可；
具体参考 [UITableVIewCell Error Xcode 7 / Swift 2](http://stackoverflow.com/questions/31774394/uitableviewcell-error-xcode-7-swift-2)


## 3、示例

本节示例代码放在当前目录下 **TableViewTest** 文件夹中；经过了之前[pickerView的教程](./picker.md)实践，本篇内容还是很容易的；

最终效果图：

![actionsheet](https://lh3.googleusercontent.com/-VvBp2IY_XrQ/V0O4tGK2bfI/AAAAAAAACsE/QKiCDiFOdhQj22BjfxJPdNRx_m5wAtSmQCCo/s800/tableview.gif)

下面是较为详细步骤说明

**Tips**：
 - 手势识别内容，请移步[Responder 及 Touches事件](./touch.md)
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)


### A. 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **TableViewTest**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）

### B. 创建UITableView实例

从组件库里拖拽 **Table View** 组件到画布上，然后设置尺寸约束：
 - 不要勾选 **Constrain to margins** 选项
 - margin-left：0
 - margin-right：0
 - margin-bottom：0
 - margin-top：20

然后设置 data source 和 delegate 对象，直接关联到当前 view controller 即可:

![data source](https://lh3.googleusercontent.com/-W-lX60XhJbE/V0O4srlwskI/AAAAAAAACsI/tBUJEI40Nzkrd5-d9kdlc83dJ0Tm3SungCCo/s800/2016-05-24_09-36-21.png)

### C. 设置UITableView外观

**先选中table view组件**，然后在属性监视器中设置该view属性：
 - 设置 **Content** 为 **Dynamic**
 - 设置 **Prototype Cells** 的值为 **1**
 - 设置 **Style** 为 **Group**

![tableview](https://lh3.googleusercontent.com/-qUZsUCVS9vs/V0O4svmzBXI/AAAAAAAACsI/el5Z1O17yPY3wY6NTY7COHaUgoZKD0fFgCCo/s800/2016-05-24_09-37-39.png)

### D. 设置Cell

在 **左边文档大纲中选中tableview cell**，在属性监视器中：
 - 设置 **identifier** 值为 **prototypeCell1**
 - 设置 **Style** 值为 **Basic**

### E. 实现协议

这是本节最后一部分内容了，挨个实现数据源对象和委托对象的协议方法。

 - [x] 让view controller继承这两个协议：

```swift
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
```

 - [x] 声明5个数组，作为基础数据：
 
```swift
    var continents:Array<String> = ["Asia","North America","Europe","Australia"]
    
    var citiesInAsia:Array<String>=["Bangkok","New Delhi","Singapore","Tokyo"]
    var citiesInNorthAmerica:Array<String> = ["San Francisco","Cupertino"]
    var citiesInEurope:Array<String> = ["London", "Paris", "Rome", "Athens"]
```

 - [x] 实现 **numberOfSectionsInTableView** 数据源，设置有几节内容：

```swift
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return continents.count;
    }
```

 - [x] 实现 **numberOfRowsInSection** 数据源，设置每一节有多少行：

```swift
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return citiesInAsia.count
        } else if section == 1{
            return citiesInNorthAmerica.count
        } else if section == 2{
            return citiesInEurope.count
        } else if section == 3{
            return citiesInAustralia.count
        }
        return 0
    }
```

 - [x] 实现 **titleForHeaderInSection** 数据源，设置每一节的标题：

```swift
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return continents[section]
    }
```

 - [x] 实现 **cellforRowAtIndexPath** 数据源，设置每一节的内容展现：
 
```swift
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("prototypeCell1",forIndexPath: indexPath)
        if indexPath.section == 0{
            cell.textLabel?.text = citiesInAsia[indexPath.row]
        } else if indexPath.section == 1{
            cell.textLabel?.text = citiesInNorthAmerica[indexPath.row]
        }else if indexPath.section == 2 {
            cell.textLabel?.text = citiesInEurope[indexPath.row]
        } else if indexPath.section == 3 {
            cell.textLabel?.text = citiesInAustralia[indexPath.row]
        }
        
        return cell
    }

```

至此打造完毕，点击运行就能查看效果了


