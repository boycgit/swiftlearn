# 标签条（UITabBar）标签页控制器（UITabBarController）

 - [标签条（UITabBar）标签页控制器（UITabBarController）用法](http://www.hangge.com/blog/cache/detail_592.html)：比较详细讲解Tab Bar组件的使用方法；
 - [iOS From Scratch With Swift: Exploring Tab Bar Controller](http://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-exploring-tab-bar-controller--cms-25470)：Tutsplus上的教程，详尽易懂

## 1、选项栏（Tab Bar）

Tab Bar controller由两个子视图组成 ： 底部的Tab Bar 和 对应的view controller；

![comp](https://lh3.googleusercontent.com/-YN5F8To2zys/V0l5vxyvliI/AAAAAAAACtw/yPUuoH4UA-AYACDdiwQPfn21l8bcKr9iwCCo/s800/figure-02.png)

在iPhone端，最多只能展现5个图标，如果有多余5个条目，则tab bar会自动将第五个变成 **更多图标**（三个点图标），而在iPad端则能展现更多的图标；

### 1.1、通过模板创建

Xcode提供名为 **Tabbed Application** 的模板，方便创建这种类型的应用；

![bar template](https://lh3.googleusercontent.com/-PkseS5hWb9c/V06_uHL3cVI/AAAAAAAACvE/CnyFAeMkTrkDUlw-AhclgM0-o4tfzGj6wCCo/s800/2016-05-28_19-07-10.png)

由模板创建程序，默认添加一个 **bar controller** 和两个 **view controller**（名字分别为 **FirstViewController** 和 **SecondViewController**）:

![vc](https://lh3.googleusercontent.com/-9VII3zEwNvs/V06_uPBlQQI/AAAAAAAACvU/cwGcIXwdNcIUDRT1D_2xtLBg50QeLn9iQCCo/s640/2016-05-28_19-09-22.png)

我们查看左侧的文档大纲，能看到3个文档对象，前两个是对应view controller，第三个则对应bar tab：

![default](https://lh3.googleusercontent.com/-0CquRMfFjws/V06_rmMtwhI/AAAAAAAACvM/rhqs0mwqg4Us8h80Mt_jJJeg8yEWkUiPwCCo/s800/2016-05-30_15-14-10.png)


App底部的tab标签页可以方便的把功能模块划分清楚，只需点击相应的标签页就可以展示完全独立的视图页面，同时各标签页间的视图也可以进行数据交换。

通过属性监视器，可以更改图标样式（System Item）：

![itemstyle](https://lh3.googleusercontent.com/-NqqCF9VEB2o/V06_rnhuyEI/AAAAAAAACvM/b_PH32TyyF4dalxd031iAPgbyHujUtlAQCCo/s800/2016-05-30_15-19-20.png)

TabBarItem系统自带图标分别有：
 - **Custom** ：自定义方式，配合Selected Image来自定义图标
 - **More** ：三个点的图标，表示更多意思
 - **Favorites** ：星形图标
 - **Featured** ：星形图标
 - **Top Tated** ：星形图标
 - **Recents** ：时钟图标
 - **Contacts** ：一个圆形一个人头像的图标，代表联系方式
 - **History** ：时钟图标
 - **Bookmarks** ：书本图标
 - **Search** ：放大镜图标，代表搜索的意思
 - **Downloads** ：正方形，加一个向下的箭头，代表下载的意思
 - **Most Recent** ：时钟图标
 - **Most Viewed** ：三条杠的笔记本纸片图标

如果你想使用自己的图标，可以将其 **Custom** ，然后配合Selected Image来自定义图标；上面通过模板生成的应用，会自动使用 **Custom** 样式，并提供相应的样式资源：

![custome](https://lh3.googleusercontent.com/-7IXT4bSHg2w/V06_rptDoLI/AAAAAAAACvM/2yDvKgDpnnstSRsWvET_jA5Gr0KLSpiMACCo/s800/2016-05-30_15-21-55.png)

### 1.2、添加Bar Item

通常来说模板创建自带两个item是满足不了需求的，这个时候就需要额外新增Bar Item；接下来我们讲解如何创建的过程：

 1. **首先，必须先创建View Controller**，这一点只需要往画布上拖拽View Controller组件即可
 2. 接着创建 **UIViewController** 的子类，通过ID监视器将该类和新建的view controller关联起来
 3. 新建Tab Bar Item，**务必要先选中当前的scene**，然后通过组件库拖拽 Tab Bar Item 组件到当前scene，Xcode会自动在当前scene的 **底部** 创建一个bar icon；若想编辑其属性，只要点击选中，然后在属性编辑器中编辑即可；
![bar item](https://lh3.googleusercontent.com/-ZI99rTrkaBc/V06_r4svrmI/AAAAAAAACvM/gbG52AmHVQQl1L7QCo9obuREJNjl3lwAACCo/s400/2016-05-30_15-33-27.png)
![baritem](https://lh3.googleusercontent.com/-SKYAmEnQLNs/V06_r6QC08I/AAAAAAAACvM/CkbiK_m8xucvOoW0DhVaw7fO0tDfWNoRwCCo/s400/2016-05-30_15-34-05.png)
 4. 最后就是关联Tab Bar和新建的view Controller，此时 **按住Ctrl键，然后从tab bar上拖拽到新scene上**（没错，你正在创建一个segue），然后在弹出的菜单中选择 **Relationship Segue**即可；


## 2、工具栏(Tool Bar)

工具栏(Tool Bar) 和 选项栏（Tab Bar）看起来很像，因为他们都是放在页面的底部；

不过也就这一点就像而已其余的都不一样；

上面说过，选项栏（Tab Bar）是为了在屏幕上让多个view controller共存，而工具栏(Tool Bar) 则是给当前的view controller提供更多的参数选择；这两者 **不会经常一起结伴使用** ，比如地图应用中，底下那条就是工具栏(Tool Bar) ；点击右下角的 **Info** 按钮就会有个弹出层，然后你就可以选择以“卫星视图”、“标准视图”等展现地图：

![map](https://lh3.googleusercontent.com/-j6uC4WlyLRM/V06_scffHEI/AAAAAAAACvM/Ocz14ZoaPJkffeUT1mXOqTtzrxEqFVrQQCCo/s800/2016-05-30_15-47-24.png)

要创建toolbar，只需要到组件库里拖拽 **Toolbar** 组件即可；不过和选项栏不一样的是，工具栏并不会自动吸附在页面的底部，需要自己手动设置尺寸约束；

工具栏里面的元素是 **UIBarButtonItem** 实例，通过拖拽 **Bar Button Item** 组件即可创建；之后选中元素，通过属性监视器就能更改对应的属性了，元素样式也可以通过下拉框选取系统自带的：

![system item](https://lh3.googleusercontent.com/-4nXkm3jTGPA/V06-T_IC5PI/AAAAAAAACuk/KsThW7py7b4UluuIN7jp2RlJqihjDhiZQCCo/s800/2016-05-31_21-57-18.png)

这里有必要讲解一下特殊的两种样式，**Fixed Space style** 和 **Flexible Space style**：前者是创建固定宽度，后者是创建可变宽度，他们只是起着分隔作用，你可以把前者想象成 **固定宽度的空格**，把后者想象成 **可伸缩的空格**，一图胜千言：
  
  ![fixed space](https://lh3.googleusercontent.com/-EBM1myobGIc/V06-T-4NDFI/AAAAAAAACuk/uwJoDZk2OxoTW7itbejdiUuOrTZKUqdxACCo/s640/2016-05-31_22-11-10.png)
  - 上图有3个item，第二个item是 **Fixed Space style**，不过界面看上去只有2个item


![flexible](https://lh3.googleusercontent.com/-Nxr7qT-J9vc/V06-UKDnZQI/AAAAAAAACuk/zNUvHY-JxjwV5ZFTLAxzPP-4ao8sMhcigCCo/s800/2016-05-31_22-14-11.png)
  - 上图有5个item，第二个和第四个是 **Flexible Space style**，不过界面看上去是三个等距离分布的item

上面是通过更改属性值创建这些特殊的item，Xcode其实也提供了直接的组件，直接拖拽就行：

![two type](https://lh3.googleusercontent.com/-c9DePmOnCvU/V06-T_3BDBI/AAAAAAAACuk/k3bNfEge8aY00oMENhpSmm1xBHgRi-ELACCo/s800/2016-05-31_22-06-43.png)

最后，别忘了在view controller中创建工具栏item对应的outlets；

## 3、示例

本节示例代码放在当前目录下 **TabbedApplicationTest** 文件夹中；所用到的图片资源放在该目录中的`images`文件夹内。

最终效果图：

![result](https://lh3.googleusercontent.com/-ljCXZgUg7Yc/V1YjS4KQUVI/AAAAAAAACvo/Qkdj70HegMowizyAHL6SilSB6GymSEI8QCCo/s800/tabbarview.gif)

下面是较为详细步骤说明

**Tips**：
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)

### A. 创建Tabbed应用，添加资源

通过xcode提供的 `Tabbed Application` 模板创建名为 **TabbedApplicationTest** 的工程；

点击 **Assets.xcassets** 文件，右键创建名为 **aboutImage** 的图像集，通过属性监视器修改 **Scale Factors** 值为 **Single Vector**，然后将 images 文件夹中的 `about.pdf` 拖拽进去就行；


我们计划把第1个tab内容设置成TableView，把第2个tab设置默认的文字修改一下；

### B. 修改第1个tab内容

TableView之前的内容我们讲过的，可以在[Table View介绍](./tableview.md)中找到详细的教程，这儿仅仅涉及如何操作；

选中 **Main.storyboard** 文件，定位到 First Table这个 scene，将默认的两个标签（内容分别为“First View” 以及 “Loaded by FirstViewController”）删除；

从组件库里拖拽 **UITableView** 到画布上，设置尺寸约束：
 - 不勾选 **Constrain to margins**
 - margin-top：20，其余3个方向上的margin都为0

打开辅助编辑器（留意一下打开的文件是 **FirstViewController.swift**），然后创建名为 `tableView` 的outlets；

接着设置 **data source** 和 **delegate** 属性，按住ctrl单击Table View组件，分别将弹出的快捷菜单中拖拽 **dataSource** 和 **delegate** 标签到左边文档大纲的 **First View Controller** 上即可；

接下先修改table view外观：
 - 选择table view，然后在属性监视器中修改
 - 设置 **Content** 属性为 **Dynamic**
 - 设置 **Prototype Cells** 属性值为 `1`
 - 设置 **Style** 值为 **Grouped**

继续修改table cell属性：
 - 展开左边文档大纲，选中table cell对象
 - 在属性监视器中，修改 **identifier** 属性为 **prototypeCell1**，修改 **Style** 属性为 **Basic**

最后，选中当前scene底部的Tab bar，在属性监视器中修改 **System Item** 属性为 **Top Rated**

### C. 修改第2个tab内容

第2个tab我们我们就不做复杂处理，就在已有的元素上稍加修改;

修改 **Second View** label内容为 **City Index**，修改 **Loaded by SecondViewController** 为 **Cities listed by

continent**

之后继续更新底部tab bar属性，设置 **Title** 属性为 **About**，修改 **Image** 值为 **aboutImage**：

![about](https://lh3.googleusercontent.com/-RKuaFqhBDyA/V1YjUTBDLTI/AAAAAAAACvs/9qQaYuf8Ug86GVHDB2V-im06znkWXcQKwCCo/s800/2016-06-06_13-19-17.png)

### D. 实现代码

其实就是实现第1个tab的Table View代码，选中 **FirstViewController** 类，修改其中的代码；

 - [x] 首先继承 **UITableViewDataSource** 和 **UITableViewDelegate**：

```swift
class FirstViewController: UIViewController,
      UITableViewDelegate,
      UITableViewDataSource {
              ....
    }
```
  
  - [x] 定义源数据  

```swift
    let continents:Array<String> = ["Asia", "North America", "Europe", "Australia"]
    let citiesInAsia:Array<String> = ["Bangkok", "New Delhi", "Singapore", "Tokyo"]
    let citiesInNorthAmerica:Array<String> = ["San Francisco","Cupertino"]
    let citiesInEurope:Array<String> = ["London", "Paris", "Rome", "Athens"]
    let citiesInAustralia:Array<String> = ["Sydney", "Melbourne", "Cairns"]
    
```

  - [x] 实现 **data source** 和 **delegate** 规范中定义的方法

```swift

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return continents.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { if section == 0 {
        
        return citiesInAsia.count } else if section == 1 {
        
        return citiesInNorthAmerica.count } else if section == 2 {
        
        return citiesInEurope.count } else if section == 3 {
        
        return citiesInAustralia.count }
        
        return 0
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return continents[section];
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("prototypeCell1", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            
            cell.textLabel?.text = citiesInAsia[indexPath.row]
        } else if indexPath.section == 1 {
            
            cell.textLabel?.text = citiesInNorthAmerica[indexPath.row]
        } else if indexPath.section == 2 {
            
            cell.textLabel?.text = citiesInEurope[indexPath.row] }
        else if indexPath.section == 3 {
            
            cell.textLabel?.text = citiesInAustralia[indexPath.row]
        }
        return cell
        
    }
```

well done，然后运行模拟器就能查看效果了；