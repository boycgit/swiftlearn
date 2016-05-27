# Collection View

 - [UICollectionView Demo in Swift](http://rshankar.com/uicollectionview-demo-in-swift/)：非常详细讲解用collection view制作一个水果展示应用

## 1、基本介绍

Collection view 和 之前讲的 table view功能类似，最大的差别在于展现上，有Grid布局、circular布局、cover-flow布局等

Collection View 是 `UICollectionView` 类的实例，组件中的数据以 **section（节）** 为单位，每节是由若干个 **item** 组成，每节的头部和尾部都是可选的；

和TableView一样，有两种方式创建Collection View，一种是拖拽 **Collection View Controller** 来创建一个新的Scene，该场景就是由collection view controller控制；

另外一种，是在已有的scene上拖拽 **Collection View** 组件，当前scene对应的view controller就会担当 collection view controller 的角色，当然，得实现 **UICollectionViewDataSource** 和 **UICollectionViewDelegate** 才行，然后将数据源和委托对象都设置成当前的view controller即可；

### 1.1、cell

每个item都是 `UICollectionViewCell`类的实例，和tableview cell一样，UIKit提供了可复用cell的机制；默认的cell大小是 **50x50** 大小的；在尺寸属性器（Size Inspector）中可以设置cell的大小和间距：

![cellsize](https://lh3.googleusercontent.com/-Hd0oWyJboe4/V0esl4DBvAI/AAAAAAAACtU/kj0FsIHTaPkld6Iil-avTKuNG8DJeeyUACCo/s800/2016-05-26_19-30-36.png)

需要在文档大纲中选中cell（注意不是collection view），然后切换到属性监视器中设置**ID**属性，方便在程序中引用实例对象；


同时还需要创建一个继承自 **UICollectionViewCell** 的子类，在ID监视器中将该子类和collection view关联起来；

![idattr](https://lh3.googleusercontent.com/-olg0dMV6mDs/V0eskYEgQpI/AAAAAAAACtU/8566DkrUt3cNY8Xh7EQ_UKbilSrHlJtjQCCo/s800/2016-05-26_20-17-34.png)

和tableview cell不同的是，collection cell默认是空白的，你必须使用UIKit元素（比如Label或者image view等）先弄出一个cell模板出来，同时需要 **设置该cell的尺寸约束**；
![cell](https://lh3.googleusercontent.com/-AX2DMvT3k3o/V0e1KB7Y-qI/AAAAAAAACtg/GE6PpliCOn4xe_yWeojx3EVKVg5v7JbYACCo/s800/2016-05-27_10-46-39.png)

一旦关联cell和对应的类关联起来之后，就可以在这个类中为cell创建对应的outlets或actions；

### 1.2、数据源和委托对象

**UICollectionViewDataSource** 和 **UICollectionViewDelegate** 协议定义了几个方法，大部分的方法是可选的，最常用的数据源协议方法是：

 - 设置sections的数量，如果不实现，默认是1个
```swift
func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
```

 - 设置每个section中的item数目

```swift
func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
```
 - 设置每个cell实例对象

```swift
func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
```

实现委托对象的主要方法是：

```swift
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
```

当用户选中某个cell的时候就会执行该方法，如果设置了`segue`，则会去调用 **prepareForSegue** 方法；


## 2、示例

本节示例代码放在当前目录下 **CollectionViewTest** 文件夹中；所用到的图片资源放在该目录中的`images`文件夹内。

最终效果图：

![result](https://lh3.googleusercontent.com/-XEjv_PwbRQo/V0eskze2ruI/AAAAAAAACs8/0uaHMNTN1u0Gz8saJw5YyM82hHhPM5LJACCo/s800/collectionview.gif)

下面是较为详细步骤说明

**Tips**：
 - 手势识别内容，请移步[Responder 及 Touches事件](./touch.md)
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)


### A. 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **CollectionViewTest**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）

### B. 添加图片资源

打开 **Assets.xcassets** 目录，通过右键中的 **New Image Set** 创建新的图片集；

首先创建名为 **Al** 的状态集，将图片 Al-1x.png, Al-2x.png, 和 Al-3x.png 拖拽到对应的框框中；同样的过程创建 F, Hg, Li, N, O, 以及 Si这些图片集；

### C. 添加UICollectionView实例

从组件库里拖拽Collection View到画布上，设置尺寸：
  - 不要勾选 **Constrain to margin**
  - margin-top:20 ，其余的3个margin距离都设置成0
  - 记得点击 **Add 4 Constraints** 按钮

设置数据源和委托对象 ，右键点击弹出菜单，分别将 **data source** 和 **delegate对象** 关联到当前View Controller上：

![datasource](https://lh3.googleusercontent.com/-92nidIBWcKo/V0esl2Cl7pI/AAAAAAAACtI/suXFrne8jLkXxhbP8t4yDymdB6OD6FX4gCCo/s800/2016-05-26_20-11-10.png)

继续设置collection view的外观：
  - 在文档大纲中选中collection view，然后点击属性监视器
  - 设置 **Layout**（布局） 为 **Flow**
  - 设置 **Scroll Direction**（滚动方向）为 **Vertical**
  - 不勾选 **Section Header**
![attr](https://lh3.googleusercontent.com/-TpzYZ-_C4-g/V0esmPN7_II/AAAAAAAACtQ/skvyHgX1YxsSRTqAgJso_Wr0QsI6wP5vACCo/s800/2016-05-26_20-14-35.png)

  - 切换到尺寸监视器（Size Inspector），设置cell高度和宽度为 **150**
  - 设置 **Top Section Inset** 的值为 **10**
![cellsize](https://lh3.googleusercontent.com/-XA4QM4kY8v0/V0esmK9o9XI/AAAAAAAACtM/3k1sh0thJbALEYbJvRLwOgtXlCfMWeqSwCCo/s800/2016-05-26_20-13-55.png)

### D. 创建UICollectionViewCell子类

在 **CollectionViewTest** 右键创建新文件，在 **iOS Templates类目** 下选择 **Swift File** 文件类型，点击下一步；

命名为 **ElementCollectionViewCell.swift** ，然后点击创建

修改该文件内容：

```swift
import UIKit 
class ElementCollectionViewCell: UICollectionViewCell {

}
```

### E. 设置cell外观

在文档大纲中选中 **collection view cell**（在collection view节点下，展开就能看到）

在属性编辑器中设置 **identifier** 属性为 **ElementCellIdentifier**，切换到ID编辑器（Identity Inspector）设置cell对应的类为刚创建的 **ElementCollectionViewCell**：

![idattr](https://lh3.googleusercontent.com/-olg0dMV6mDs/V0eskYEgQpI/AAAAAAAACtU/8566DkrUt3cNY8Xh7EQ_UKbilSrHlJtjQCCo/s800/2016-05-26_20-17-34.png)

拖拽 **Image view** 组件到这个cell中，然后设置该图片组件在cell中的尺寸约束：
  - 不要勾选 **Constrain to margin**
  - 4个margin距离都设置成0
  - 记得点击 **Add 4 Constraints** 按钮

打开辅助编辑器，然后在里面打开 **ElementCollectionViewCell.Swift**，选中image view组件，拖拽到该swift文件中创建名为 **imageView** 的outlets

### F. 实现数据源和委托对象

接下来就是代码层面的修改了；

 - [x] 在ViewController.swift中添加元数据：

```swift
    var statesOfMatter:Array<String> = ["Solid","Liquid","Gas"]
    var solids:Array<String> = ["Li","Al","Si"]
    var liquids:Array<String> = ["Hg"]
    var gasses:Array<String> = ["N","O","F"]
```
 
 - [x] 修改 **ViewController** 的定义，让其继承 **UIViewController**, **UICollectionViewDataSource** 和 **UICollectionViewDelegate**

```swift
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
  ...
}
``` 
 
 - [x] 实现数据源的 **numberOfSectionsInCollectionView** 方法，设置section的数量：

```swift
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return statesOfMatter.count
    }
    
```
 
 - [x] 实现数据源的 **collectionView(collectionView, numberOfItemsInSection)** 方法，设置每section中的cell数量

```swift
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return solids.count
        } else if section == 1{
            return liquids.count
        } else if section == 2{
            return gasses.count
        }
        
        return 0
    }
```
 
 - [x] 实现数据源的 **collectionView(collectionView, cellForItemAtIndexPath)** 方法，具体构造cell内容

```swift
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell:ElementCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ElementCellIdentifier", forIndexPath: indexPath) as! ElementCollectionViewCell
        var elementName:String = "";
        if section == 0{
            elementName = solids[row]
        }else if section == 1{
            elementName = liquids[row]
        } else if section == 2{
            elementName = gasses[row]
        }
        cell.imageView.image = UIImage(named: elementName)
        return cell
    }
```
 
好了，点击运行按钮就能查看效果了