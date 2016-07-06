# Property Lists

 - [Load Data from Property List in iOS8 with Swift](http://www.ioscreator.com/tutorials/load-data-property-list-ios8-swift)：在swift中如何加载简单数据；
 
 - [HOW TO USE PROPERTY LISTS (.PLIST) IN SWIFT](https://makeapppie.com/2016/02/11/how-to-use-property-lists-plist-in-swift/)：长篇详细介绍使用.plist的方式
 
 - [Read and Write Plist File in Swift](http://rebeloper.com/read-write-plist-file-swift/)：上面教程仅仅是包括读取的，该教程还包含写的； 


## 1、新建
plist文件是典型的 **XML**文件，通常是存储轻量级的配置文件信息，比如 **服务器地址** 、**环境配置** 等

新建 plist 文件也很简单，在新建菜单中选择 **iOS -> Resource** 即可；使用Xcode自带的编辑器就能编辑该文件，该xml文件的根节点名字是 **Root**

使用程序创建 plist 文件，需要准备dictionary或者array数组，下面的代码片段能帮你达到目的：

```swift
func writeToPlist(fileName:String!, data:NSMutableDictionary!) 
{ 
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String 
    let path = paths.stringByAppendingPathComponent(fileName) 
    data.writeToFile(path, atomically: true) }
```

写到plist中的数据必须实现 **NSCoding** 接口，常用的 **NSNumber, NSString, NSArray, NSDictionary, 和 NSData instances** 都默认实现这个接口了；

**NSCoding** 包含两个方法，`encodeWithCoder(aCoder: NSCoder)` 和 初始化方法 `init?(coder aDecoder: NSCoder)`，下列代码展示了如何让自定义的 **Employee** 类实现该接口的：

```swift
import UIKit

class Employee: NSObject, NSCoding {

    var name:String? 
    var address:String?

    func encodeWithCoder(aCoder: NSCoder) { // write to plist here. 
        aCoder.encodeObject(name) 
        aCoder.encodeObject(address)
    }

    required init?(coder aDecoder: NSCoder) { // read from plist here 
        name = aDecoder.decodeObjectForKey("name") as? String 
        address = aDecoder.decodeObjectForKey("address") as? String 
    }

}
```

## 2、读取

同样的，读取plist文件之后需要将数据存储成array 或者 dictionary,下列代码就是读取名为 **Config.plist** 文件配置内容的：

```swift
var plistDictionary: NSDictionary? 

if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
  plistDictionary = NSDictionary(contentsOfFile: path) 
} 

if let unwrappedDictionary = pListDictionary {
  // Use unwrappedDictionary here 
}
```

## 3、示例

本节示例代码放在当前目录下 **PropertyListTest** 文件夹中；主要功能是当用户启动程序的时候先创建一个plist文件等启动完毕之后，把plist中的内容读取到table view中；

效果图如下：

![result](https://lh3.googleusercontent.com/-r7QqN-KwuRI/V3yc_5H30AI/AAAAAAAAC08/DIxGUaGlR7osvIkJxqfY7BrvvnXbaajawCCo/s800/2016-07-06_11-38-03.png)

**Tips**：
 - 有关tableView的详细说明，请参考[Table View介绍](./tableview.md)
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](../basic/adaptive.md)


### A. 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **PropertyListTest**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）


### B. 添加UITableView组件

从组件库里拖拽Table View放到画布上，设置其尺寸约束：
 - 不要勾选 **Constrain to margins** 选项
 - margin-left：0
 - margin-right：0
 - margin-bottom：0
 - margin-top：20

然后右键单击该组件，在快捷菜单中依次选择 **dataSource** 和 **delegate** 和左边文档导航中的 **View Controller** 关联起来；

继续设置table view组件，**选择导航中的table view**
  - 在属性监视器中设置 **Content** 属性为 **Dynamic**
  - 设置 **Prototype Cells** 数值为 1
  - 设置 **Style** 为 **Group**

展开左边导航，选中 **table view cell**:
  - 在属性监视器中，设置 **identifier** 为 `prototypeCell1`
  - 设置 **Style** 为 **Basic**

### C. 在程序启动的时候创建plist

我们需要在 **AppDelegate.swift** 文件中修改`application(application, didFinishLaunchingWithOptions launchOptions) -> Bool`方法为：

```swift
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // 如果不存在contacts.plist文件，创建之
        let fileManager:NSFileManager! = NSFileManager.defaultManager()
        let documentsDirectory:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        let plistPath = documentsDirectory + "/contacts.plist"
        
        if fileManager.fileExistsAtPath(plistPath) == false {
            
            let contacts:NSMutableArray = NSMutableArray()
            contacts.addObject("张三")
            contacts.addObject("李四")
            contacts.addObject("王五")
            contacts.addObject("赵六")
            
            contacts.writeToFile(plistPath, atomically: true)
        }
        return true
    }
```

  - 首先创建`fileManager`，设置文件存储路径
  - 如果不存在 **contacts.plist** 文件，则创建一个含有4个条目的数据内容
  - 然后保存到指定的文件路径里

这里说一下创建的文件路径，并不是在自己的工程目录下，而是在用户本地目录特定的位置下：

![path](https://lh3.googleusercontent.com/-SdbMN6ZI_ME/V3yc_amNsUI/AAAAAAAAC04/9O_BfoxNXdkDKyHGZSvnIArFOuIZxy3nQCCo/s800/2016-07-06_11-46-28.png)

### D. 当视图加载读取plist文件

打开 **ViewController.swift** 文件，让它实现 **UITableViewDelegate** 和 **UITableViewDataSource**：

```swift
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  ...
}
```

然后添加变量：

```swift
var arrayOfContacts:NSArray? = nil
```

接着在 **viewDidLoad** 方法中读取plist文件内容，然后存储在array数组中：

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // 载入contact.plist文件中的内容
        let documentsDirectory:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        let plistPath = documentsDirectory + "/contacts.plist"
        
        arrayOfContacts = NSArray(contentsOfFile:plistPath)
        // Do any additional setup after loading the view, typically from a nib.
    }
```

最后就是经典的实现tableview指定的方法了：

```swift
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfContacts!.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("prototypeCell1",forIndexPath: indexPath) as UITableViewCell
        let contactName:String = arrayOfContacts!.objectAtIndex(indexPath.row) as! String
        
        cell.textLabel?.text = contactName
        
        return cell
    }
```

点击运行就能查看效果了；



