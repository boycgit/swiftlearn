# 应用设置


## 1、基础
如果你想通过 Apple's Settings application （通过iphone中的设置项）设置应用，你需要提供 **Settings.bundle** 文件;

当你打开iPhone中的 **设置**，系统会检查第三方应用有没有 **Settings.bundle** 文件，如果有的话会在左边的主菜单上添加应用的图标和名字；如果想自定义图标，需要在工程Assets目录中提供名为 **AppIcon** 的资源

但用户active当前应用的时候，记得要重新读取一遍设置项，这样用户就能马上能看到效果了；

通过右键菜单，然后选择 **iOS->Resource->Settings Bundle** 新建文件：

![create](https://lh3.googleusercontent.com/-WP0QXzyQetw/V4XdNbJyeJI/AAAAAAAAC1s/NTFCIx0sOB4XFpCJzew1vkECqyZncTDRwCCo/s640/2016-07-13_13-47-16.png)


其实这个文件像个目录，它是一系列文件的 **集合**；在这个目录下，包含名为 **Root.plist** 的属性文件，这个文件会控制你的应用会在系统设置中展现的样子；

![root](https://lh3.googleusercontent.com/-obBQYTWpLmI/V4XdNQqXFVI/AAAAAAAAC1s/0zwTF9RQ1vg8kmRmPgSojqKEDMYLfLpkACCo/s800/2016-07-13_13-51-20.png)

打开这个属性文件，它仅仅包含两项属性：
  - **Preference Items** 数组：这里设置你想展现给用户看的设置项，默认包含四项设置，都是字典类型
  - **Strings Filename** 字符串：

![preference](https://lh3.googleusercontent.com/-Wyn-xGhDOVM/V4XdNYZKgSI/AAAAAAAAC1s/EI_xShC2rFEqFgTit_GWBkqDgajUfFdPwCCo/s800/2016-07-13_13-51-39.png)


Preference Items 包含的元素的属性中比较重要的key有4个：**Title**（不可编辑的字符串）, **Type**（数据类型，不同的类型展现给用户UI不一样）, **Identifier**（相当于变量名，用于程序）以及 DefaultValue（默认值）.

其中数据类型有：

| Type  | 描述  |
|---|---|
| Text Field | 可编辑输入框  |
| Toggle Switch | On/Off 开关器  |
| Title | 只读标题  |
| Slider | 滑动器，用于取值  |
| Multi Value | 多值选择器  |
| Group | 配置项群组   |
| Child Pane | 子配置项页  |

![types](https://lh3.googleusercontent.com/-NxucMkBi5bc/V4XdNxhzDoI/AAAAAAAAC1s/yKcFzgVojykVfPPOvYRt4t0NUxgdhFAsgCCo/s800/2016-07-13_13-54-19.png)


## 2、读取配置项

为了读取设置项，需要使用 `NSUserDefaults` 对象，该对象来自 **Core Foundation** 框架，提供了一系列方法操作配置项；

该对象是 **单例模式**，通过下列代码获取其引用：

```swift
let userDefaults = NSUserDefaults()
```

这个时候上述说的 **Identifier** 就派上用场了，比如我们想要获取 `user_name` 中用户设置的值：

```swift
let userName = userDefaults.valueForKey("user_name") as? String
```
上述代码假定 `user_name` 是字符串类型，当然还有其他的类型可供使用：

 - boolForKey
 - floatForKey
 - doubleForKey
 - integerForKey

需要注意的事，虽然你在设置中提供了默认值，不过这些值 **只有当用户安装了你的应用，并打开设置项之后才会生效**，因为为了容错，你必须在代码里准备一份相同的默认值；

不管用户有没有打开设置应用，你都想使用 **NSUserDefaults** 类中的方法获取变量内容，你需要先让默认值同步一份数据：

```swift
let registrationDictionary:[String: String] = ["user_name":"Paul Woods", "user_age":"28"]

userDefaults.registerDefaults(registrationDictionary)
userDefaults.synchronize()
```

## 3、示例

本节示例创建了一个简单的应用，根据读取设置中的用户信息（用户名和年龄），然后简单地展现在label中；

代码放在当前目录下 **SettingsTest** 文件夹中，最终效果图：

![result](https://lh3.googleusercontent.com/-CKShQWXnphU/V4XdO4wQCiI/AAAAAAAAC1s/WBrbcuSXei0e19csJNbDKU3lgTYNWl_IgCCo/s400/setting.gif)

下面是较为详细步骤说明

**Tips**：
 - 创建Outlets、设置尺寸约束，请移步[自适应布局](./adaptive.md)


### A. 创建单应用

在iOS项目卡下选择 **Single View Application** 应用程序，项目名为 **SettingsTest**，填写资料的时候 **不用勾选** 最底下的3个选项框（Use Core Data啥的）；

### B. 创建setting bundle并编辑
在文件导航栏上的 **Settings Test** 右键创建settings bundle，命名成 **Settings.bundle**；

 1. 展开Settings.bundle文件中的 **Preference Items** ，删除默认的第2、3项（Toggle Switch 和 Slider 两项），点击并按 backspace 按键就行了；

 2. 编辑 **Item 1 (Text Field – Name) ** 条目，设置 `Title` 为 **用户名**，设置 `Identifier` 为 **user_name**，设置 `Default Value` 为 **JSCON**
 3. 然后在 Item 1 上右键创建一条新的Item，设置 `Title` 为 **用户年龄**，设置 `Identifier` 为 **user_age**
![new item](https://lh3.googleusercontent.com/--5MRr9MLNCk/V4XdN6XNXSI/AAAAAAAAC1s/sVGyT33g6HAHbJRHulhGSXWNb1hzRxQLACCo/s800/2016-07-13_13-55-32.png)
 4. 在最后一个属性（Identifier）的右边点击新增按钮，新增 `Default Value`，并设置为 **26**
![addprop](https://lh3.googleusercontent.com/-vehlUSL0H20/V4XdN-5bgiI/AAAAAAAAC1s/9coAIMqf_8ov3ZHb8n8aeemQ6ma3BkmewCCo/s800/2016-07-13_13-56-48.png)


### C. 添加两个Label

打开 **Main.storyboard** ，然后从组件库里拖拽两个label到当前画布上，设置尺寸约束为（两个设置值都一样）：
 - 不要勾选 **Constrain to margins** 选项
 - margin-left：20
 - margin-right：20
 - margin-top：20
 - height : 21

更新视图之后，分别创建这两个label对应的outlets变量名：`nameLabel`和`ageLabel`

### D. 编写功能代码

最后在 viewDidLoad() 编写功能代码，非常的简单：

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let userDefaults = NSUserDefaults()
        let registrationDictionary:[String:String] = ["user_name":"JSCON","user_age":"26"]
        userDefaults.registerDefaults(registrationDictionary)
        userDefaults.synchronize()
        
        nameLabel.text = userDefaults.valueForKey("user_name") as? String
        ageLabel.text = userDefaults.valueForKey("user_age") as? String
        
    }
```

保存，点击运行就能查看到效果了；