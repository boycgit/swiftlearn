# storyboard

简言之，storyboard由 **scenes** 和 **segues** 组成；

## 1、概述

### 1.1、什么是scene
选中的 scenes 的顶部那条叫 **dock**，上面 **有3个按钮** 分别代表三种高层次级别的screen状态；

![status](http://ww1.sinaimg.cn/large/514b710agw1f3b01vqxoqj20hs01zt8k.jpg)

第一个就是 ViewController 状态，主要的工作时间大部分都花费在这个地方；

第二个就是 FirstResponder 状态，就是唤起App时的逻辑处理

第三个就是 Exit 状态，是在程序退出的时候的逻辑处理；


写页面就好比写论文一样，是有树形大纲的，“章节包含文章，文章又有标题、内容组成”，可以点击左下角的按钮，展现出当前UI界面的层级结构；

![doc tree](http://ww3.sinaimg.cn/large/514b710agw1f3b02wjhzsj208y0dumxw.jpg)

自己可以展开来挨个点一遍，就能体会到这个树形大纲的作用；


> 提示：在storyboard上双击，就能以全局视觉观察效果图了


默认创建的是单个scene，如果要想有多个scene，需要在库中添加 **View Controller** 对象；

添加完scene还不算，还需要认领一个对应的controller才行，添加 **Cocoa Touch Class** 类：

> 确保是继承自 **UIViewController** ，不要勾选 **also create XIB file** 选项

然后和对应的 scene 进行关联；

### 1.2、什么是segue

segue 就是过场，从一个scene 到下一个 scene 是需要过渡的，这个过渡就叫做 **segue**；

![segue](http://ww4.sinaimg.cn/large/514b710agw1f3b05sbcjxj20dg09oq4b.jpg)

说到过场，其作用有两方面作用：

 - 一个是 **页面路由**，用户在这个A页面上点击某个按钮，按照逻辑规则可以导向 B 页面，或者导向C页面；
 - 另一个就是 **设计过场动画**

在 storyboard 设计中，一个弹窗（modal) 也算是一种 scene，所以弹窗和当前页面之间也是使用 segue链接起来的；

链接两个scene也有两种方式：

 - **右键** 选中源scene，然后拖拽到目标scene
 - 按住 **Ctrl键**，选中源scene然后拖拽到目标scene

在界面中，segue 的表现就是 **scene 和 scene 之间的 连线**，单击选中这个连线就能像编辑组件那样编辑它的属性了；
每个segue 都必须有ID号以区别彼此，编辑的时候给它一个字符串ID;

执行功能的时候（比如点击页面上不同的按钮点击导向到不同的scene），需要覆盖 **prepareForSegue** 方法:

```swift
override func prepareForSegue (segue: UIStoryboardSegue, sender: AnyObject?) {

}
```
 - 第一个参数`segue` 是 `UIStoryboardSegue` 对象，代表当前segue，其中`identifier`属性就是刚才定义的ID，`sourceViewController` 和 `destinationViewController` 就分别源scene和目标scene了；
 - `sender`参数是类似于发起segue的对象（比如在点击某个按钮进行segue，那么sender对象就是这个按钮了）


## 2、示例

本节以创建简单的水果列表（**FruitList**） 为例，讲解最基本的创建 scene 和 segue 方法；

![demo](https://lh3.googleusercontent.com/-h8Vl7ZHZrPw/VyAYVbojfSI/AAAAAAAAChw/hRaanLtbe8ETtv_RqkOZHY0gOH1aC3EfACCo/s800/lesson%2B10%2B-%2Bstoryboard.gif)

> 本节代码示例放在当前目录下的 **FruitList** 目录里

### 2.1、大致流程

以防止大伙儿看得太花，总结一下大致的流程：

 1. 创建Single View Application应用
 2. 添加图像资源到你的工程项目
 3. 创建 **NSObject** 子类 —— **FruitClass**
 4. 给 **FruitListViewController**  中添加一个数组，数组里包含3个 **FruitClass** 的实例；
 5. 在首屏添加 **UILabel** 和 3个 **UIButton** (用于跳转到不同的下一页)
 6. 再创建一屏到当前storyboard，同时创建名为 **FruitDetailViewController** 的 **UIViewController** 子类到当前工程目录
 7. 更改新建屏幕的ID
 8. 从首屏的4个按钮到次屏幕，创建约4个segues
 9. 重写 **ViewController** 类中的 **prepareForSegue:sender** 方法，将当前屏幕中水果的信息作为参数传入；
 10. 在第二屏上添加UI元素，展现所选水果的信息；
 11. 在第二屏上添加一个 **UIButton** ，用于返回到首屏

这些大致的流程是起提纲作用的，如果读者都知道每一步的操作，那么本篇就可以跳过；

接下来将是详细的操作步骤。

### 2.2、详细步骤

#### A. 创建FruitList类

使用xcode创建一个新的 `Single View Application` 工程，工程名为 **FruitList**:

![创建工程](http://ww3.sinaimg.cn/large/514b710agw1f3bn4384hnj20ka0eewfm.jpg)

 - Use Core Data: 不勾选
 - Include Unit Tests: 不勾选
 - Include UI Tests: 不勾选



#### B. 添加图片资源

点击左侧项目导航栏中的 **Assets.xcassets** 文件，接下来我们将创建4个图片资源集合，用于程序中调用展现出来：

通过菜单 Editor ➪ New Image Set 创建用作背景(background)的图片集合，依次将文件background1x.png, background2x.png, and background3x.png 拖到对应的占位符中行了；

> 图片都放在 **FruitList/image/** 文件中了

类似的，我们创建 apple 、 banana 和 orange 的图片集合；

![add assets](https://lh3.googleusercontent.com/-FzKV0mmgqy8/VyDJ1-6QepI/AAAAAAAACj0/yObhKU-UFOstiUZd8aMTGb7xsSPpwoJjACCo/s800/2016-04-24_22-19-21.png)


最后添加之后的效果为：

![final assets](https://lh3.googleusercontent.com/-zWagCFik5Jk/VyDNJ-BLWfI/AAAAAAAACkI/8U_N0ZCSiWUMel_Z86-Z3X2vTCP_vjfMgCCo/s800/2016-04-27_22-30-12.png)


#### C. 创建背景图

点击 Main.storyboard，从组建库里拖一个 **Image View** 到scene中，通过 **Attribute inspector** 设置 **Image** 属性，其实在选择的时候会弹出一个下拉框，里面列举之前我们添加的图片资源名，选择 **background** 就行；

![set background](https://lh3.googleusercontent.com/-c1xLiFnKk9w/Vyv4CY-8MZI/AAAAAAAACkU/R2ljPefZbM0bDYXBtotIImKNlVLbYPyhgCCo/s800/2016-05-06_09-48-24.png)

这样图片已经关联到这个组件里了，不过我们想让背景图撑满整个scene，还需要设置 **尺寸约束（constraints）**

 -  不要勾选 Constrain to margins 选项
 -  四个方向的margin都设置成 0 ，这样图片四条边都会紧贴scene的四条边缘
 -  不要忘记点击底部的 **Add 4 Constraints** 按钮

> 如果不知道如何创建Constrain，请看[自适应布局](./adaptive.md)

现在你可以尝试运行程序预览，可以看到灿烂的背景了，也算是给自己一点点鼓励；当然后面还有很多东西要放置，我们继续吧~

#### D. 添加按钮并布局

我们的初衷是放置三个按钮，点击之后分别跳转到不同水果的详细界面；

那我们拖拽三个按钮（从组件库里）放置到scene上；
 - 依次双击按钮，设置按钮名称为 **orange**、**apple** 、**banner** 
 - 设置按钮背景颜色为白色，字体颜色为黑色
 - 使用 **Pin constraints** 设置按钮的尺寸，宽度为 165，高度为 40 的约束
 - 然后我们还得设置按钮的位置约束，使用 **Align constraints**，三个按钮都设置水平居中；至于垂直方向，设置中间按钮为垂直居中，上下两个按钮以它为参考对象，设置margin约束就行了（我这里设置成 30 距离，其实大家可以自行设置，不要让按钮跑到scene外面就行了）；
 
点击右下角的 **Update Frames** 刷新查看一下布局是否正确；

![final view](https://lh3.googleusercontent.com/-9iIa1H8wLR8/Vyv46HC5RXI/AAAAAAAACkg/FkXbCyGu8NYGVyLmyYIJ5y3WbbvZJ-lzwCCo/s800/2016-05-06_09-52-13.png)

到这里为止都还只是准备工作，从下一步开始才进入到本节的核心内容；

#### E. 为水果创建一个Class

为了能代表 **水果** 这个概念我们有必要为其创建一个类，而苹果、香蕉都是这个类的实例：

 1. 在导航栏 **右键FruitList组** ，在弹出的菜单里选择 **New File** 创建新文件；
 ![new file](https://lh3.googleusercontent.com/-B8vmyYUuLRk/VyDJhe-L50I/AAAAAAAACj4/80EnOshqd3Ayj5WGzqbafICSkyur_A55wCCo/s800/2016-04-26_00-08-05.png)
 2. 选择 **Cocoa Touch Class** 模板，点击下一步
 ![cocoa touch class](https://lh3.googleusercontent.com/-xnwx2Tnf-zY/VyDJh00d7MI/AAAAAAAACj4/dno9CqYXImUoYXIn4u0yNLG7B_b9WEaBQCCo/s800/2016-04-26_00-08-27.png)
 3. 填写类名为 **FruitClass** ，确保该新创建的类继承自 **NSObject** 类，通过下拉框选择就行，点击下一步
 ![create class](https://lh3.googleusercontent.com/-qXtneqB_y0U/VyDJh6HBzcI/AAAAAAAACj4/K_i5iTJhDQEoFgsXoPQD4YMIM5yn5lllACCo/s800/2016-04-26_00-11-07.png)
 4. 选择保存文件的位置，用Xcode提供的默认文件夹位置就行
 5. 修改 **FruitClass.swift** 其中的代码为：

```swift
import UIKit
import Foundation

class FruitClass: NSObject {
    var fruitName:String!
    var fruitImage:String!
    var fruitFamily:String!
    var fruitGenus : String!

    init (fruitName:String, fruitImage:String, fruitFamily:String, fruitGenus:String) {
        self.fruitName = fruitName;
        self.fruitImage = fruitImage;
        self.fruitFamily = fruitFamily;
        self.fruitGenus = fruitGenus;
        
    }
}
```

这是一个简单的类，仅仅是包含水果的4种属性而已；

接下来，我们要在主程序 **ViewController.swift** 中添加一个数组，将初始化水果类的3个实例（**orange**、**apple** 、**banner** ），并放置到这个数组中：

```swift
import UIKit

class ViewController: UIViewController {
    
    var arrayOfFruits:[FruitClass] = [FruitClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let apple:FruitClass = FruitClass(fruitName: "Apple", fruitImage: "apple", fruitFamily: "Rosacae", fruitGenus: "Malus")
        
        let banana:FruitClass = FruitClass(fruitName: "Banana", fruitImage: "banana", fruitFamily: "Musacae", fruitGenus: "Musa")
        
        let orange:FruitClass = FruitClass(fruitName: "Orange", fruitImage: "orange", fruitFamily: "Rutacae", fruitGenus: "Citrus")
        
        arrayOfFruits.append(apple);
        arrayOfFruits.append(banana);
        arrayOfFruits.append(orange);
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ...

}

```

#### F. 创建新的scene并绑定viewController

创建一个新的scene之前，我们先为它 **准备一个对应的类**，方便程序层面的操作；

新建名为 **FruitDetailViewController** 的类，继承自 **UIViewController** 基类：

 1. 在导航栏 **右键FruitList组** ，在弹出的菜单里选择 **New File** 创建新文件；
 2. 选择 **Cocoa Touch Class** 模板，点击下一步
 3. 填写类名为 **FruitDetailViewController** ，确保该新创建的类继承自 **UIViewController** 类，通过下拉框选择就行，点击下一步
 4. 确认没有勾选 **Also create XIB file**选项
 ![new view controller](https://lh3.googleusercontent.com/-Nt4UYt7ZFz8/VyDJh1-lnOI/AAAAAAAACj4/M6vZFLdfkBkbsr0PEDq0bu5mp8cilHujwCCo/s800/2016-04-26_00-16-57.png)
 5. 选择保存文件的位置，用Xcode提供的默认文件夹位置就行

然后我们在storyboard上创建另一个新的scene：

 1. 选中 **Main.storyboard** 文件
 2. 从组件库里拖拽 **View Controller** 对象到 storyboard 画布上；
 3. 双击 canvas 缩小
 4. 拖拽新创建的scene放在第一个scene旁边，你爱怎么放就怎么放，不要重叠就好
 5. 选中新scene，在 **Identity inspector** 中更改 **Custom class** 值为 **FruitDetailViewController**，这样就将这个新scene和类对应关联起来了；
 6. 
![custom class](https://lh3.googleusercontent.com/-b_E1l5fVSKQ/VyDJiekx0sI/AAAAAAAACj4/z-DeLJeHmk0eaW1QlZwOfvCW6jCyYxwoQCCo/s800/2016-04-26_00-19-26.png)
 

#### G. 在新scene上新建UI元素

又回到了最原 **始拖拽UI元素 - 设置元素位置constraint** 的过程，折腾的最终效果如下：

![second](https://lh3.googleusercontent.com/-V6cuR6Vbs9k/Vyv5mI0MJyI/AAAAAAAACkk/-9eb6akdtY814gGp7OV4DtIcYDL9PLhZgCCo/s800/2016-05-06_09-55-15.png)


下面一一阐述，略显啰嗦：

 1. 添加背景图，这个和创建首个scene的过程一模一样，这里略过
 2. 新增一个 **Image View** 作为展览图，用于展示水果图片：
     - 通过 **Align button** 添加水平垂直居中约束（共2个约束）
     - 通过 **Pin button** 设置图片尺寸为 128 x 128 （两个约束）
 3. 添加顶部内容为 **你选择了** 的label：设置水平居中，在展览图上方 30 处，字体大小26
 4. 添加额外说明的3个label，每个label都水平居中，相互垂直距离15，依次修改label内容为：**水果名称** 、**水果家族** 、**水果品种**
 5. 创建一个 **返回** 按钮：
    - 从组件库里拖拽 **Button** 对象
    - 双击修改文本内容为 **返回**，同时设置其底色为白色
    - 设置按钮位置：通过 **Align button** 添加水平居中约束，距离上一个label 为15，通过 **Pin button** 设置尺寸为 165 x 40

通过上面的操作，界面上的元素已经齐全，接下来我们要为他们添加行为代码了；

#### H. 创建outlets & actions

打开 **Assistant Editor** 视图，确保打开的是 **FruitDetailViewController.swift** 文件；找不到的同学可以通过jump bar定位到，见下图：

![location file](https://lh3.googleusercontent.com/-2oiEstb_XCQ/Vyv7v0GH9QI/AAAAAAAACkw/1SPpz_4XTcUC271NYFBoaHbYhfRjy4SyQCCo/s800/2016-05-06_10-02-49.png)


然后通过拖拽在该文件中创建4个outlets和1个按钮actions
 - 1个展览图对象的 outlets，名为 **fruitImage** ；
 - 3个label对象的 outlets，分别名为 **fruitNameLabel**、**fruitFamilyLabel**、**fruitGenusLabel**
 - 1个返回按钮的actions，名为 **onBack** 方法，按钮事件为 **Touch Up Inside**

![outlets](https://lh3.googleusercontent.com/-GApGJXru42U/Vyv8vRDGAkI/AAAAAAAACk8/DvrXNeG3k_o9mN4FC7p62TJxPopcP-UdACCo/s800/2016-05-06_10-07-13.png)

> 不知道如何创建 outlet 或者 action 的，请参考文章 [自适应布局](./adaptive.md)

这样就会自动在 **FruitDetailViewController.swift** 文件中创建相对应的变量

```swift
import UIKit

class FruitDetailViewController: UIViewController {
    
    var dataObject:FruitClass?

    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var fruitFamilyLabel: UILabel!
    @IBOutlet weak var fruitGenusLabel: UILabel!
    @IBAction func onBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    override func viewDidLoad() {
      ...
    }
    
    ...

}
```

其中按钮事件中的代码 `dismissViewControllerAnimated();` 就是返回上一页的方法；

#### I. 创建segues

前面讲了那么多都是铺垫，两个scene上都有内容，不过两者并没有联系起来；为了点击第一屏幕的按钮跳转到第二个屏幕上，首先需要为其创建segues：
 1. 选择 Main.storyboard 文件，选中第一个scene
 2. 在 **orange** 按钮上右键，按住 **Triggered Segues** 下的 action 项右边的小圆点，拖拽到第二个scene上，放开鼠标就会弹出一个框，让你选择segue的类型，我们选择 **Present Modally**
![create segue](https://lh3.googleusercontent.com/-nxKC5-WD22U/VyDJjO9RbdI/AAAAAAAACj4/MPS7hZ_5qWM8mQVC-zPryfdYVz_K0yiQACCo/s800/2016-04-26_12-51-19.png)
 
 3. 点击连线中间的圆形选中当前segue，在属性检查器中命名其为 **orangeSegue**
![orangeSegue](https://lh3.googleusercontent.com/-whgxVbTc5KY/VyDJipjGsxI/AAAAAAAACj4/nC3uYfS847cyJSxdGghLCfVRqEErAxNCgCCo/s800/2016-04-26_12-53-00.png)

 4. 同样的为其他两个按钮创建segue，名字分别为 **appleSegue** 和 **bananaSegue**，这样你讲看到三条segue连线
![many segue](https://lh3.googleusercontent.com/-aCiLGsYbjj0/VyDJjJs9nNI/AAAAAAAACj4/JKDX8vA7mK4vLs5cCCo34ubbEsLU-h9fgCCo/s800/2016-04-27_09-27-23.png)

打开 **ViewController.swift** 文件，因为创建了segue对象，我们需要重写 **prepareForSegue:sender:** 方法，表示在segue之前所需要执行的方法（类似于React中的 componentWillMount）：

```swift
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "appleSegue"){
            let objectData :FruitClass = self.arrayOfFruits[0]
            let destination = segue.destinationViewController as! FruitDetailViewController
            destination.dataObject = objectData
        }else if (segue.identifier == "bananaSegue") {
            let objectData:FruitClass = self.arrayOfFruits[1]
            let destination = segue.destinationViewController as! FruitDetailViewController
            
            destination.dataObject = objectData;
            
        } else if (segue.identifier == "orangeSegue") {
            let objectData:FruitClass = self.arrayOfFruits[2]
            let destination = segue.destinationViewController as! FruitDetailViewController
            
            destination.dataObject = objectData;
            
        }
    }

```

上段代码主要意思：

 - 通过 `segue.identifier` 变量判断是哪条segue线
 - 创建 `objectData` 变量，将对应的 `arrayOfFruits`数组中的水果实例赋值给它
 - 定义 `destination` 变量，获得跳转后的 viewController对象，这里很明显是第二个scene对应的viewController，因此通过 as 关键字强制类型转换，并使用 `!` 进行强制拆包；
 - 最后通过 `destination.dataObject = objectData` 将水果变量赋值给第二个viewController实例对象（即FruitDetailViewController实例）；

此时你的Xcode可以会在 `destination.dataObject = objectData;` 这行代码有错误提示，这是因为 **FruitDetailViewController** 实例不存在 **dataObject** 属性导致的；

我们修复此问题，需要打开文件 **FruitDetailViewController**，添加这个对象；


```swift

import UIKit

class FruitDetailViewController: UIViewController {
    
    var dataObject:FruitClass?

    @IBOutlet weak var fruitImage: UIImageView!
    ...
    
}
```


一旦FruitDetailViewController实例获取dataObject对象，就以该对象作为初始值传入，然后一一初始化该对象的具体属性；这个过程是在 **viewDidLoad()** 方法中执行的：

```swift

import UIKit

class FruitDetailViewController: UIViewController {
    
    var dataObject:FruitClass?

    @IBOutlet weak var fruitImage: UIImageView!
    ...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataObject = dataObject else {
            return
        }

        fruitImage.image = UIImage(named:dataObject.fruitImage)
        fruitNameLabel.text = "水果名称：\(dataObject.fruitName)"
        fruitFamilyLabel.text = "水果家族：\(dataObject.fruitFamily)"
        fruitGenusLabel.text = "水果品种：\(dataObject.fruitGenus)"
        
        
        // Do any additional setup after loading the view.
    }
    ...
}
```

> 这里用到了guard 关键字，可参看 [错误处理](./error-handle.md)

写到这里总算是把所有的细节都写完了，至此就可以运行该程序，看到的效果就如本文最初那样；

本文虽然简单，不过包含了如何创建segue的最基本流程，麻雀虽小，五脏俱全；