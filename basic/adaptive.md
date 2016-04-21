# 自适应布局

写过界面的人，最想做的事情是写一套代码可以在各个终端适配布局 —— 在前端领域，这叫 **响应式布局** ； 

写 iOS 应用的人，要适配不同的设备（比如 iphone 和 iPad 系列），所采用的是 **自适应布局（Adaptive Layout）**，名字不一样，但目的都是一样的；

布局的控制可以通过代码层面，使用[NSLayoutConstraint](https://developer.apple.com/library/ios/documentation/AppKit/Reference/NSLayoutConstraint_Class/)类来编写，或者使用[EasyPeasy](https://github.com/nakiostudio/EasyPeasy)这个库来简化代码，但这种高阶技能对初学者来讲有些头大，所以这里我们采用简单的方式，使用界面化方式，即通过 **Interface Builder** 搭建；

> 示例文件在当前目录下的 `adaptive` 文件夹里

## 1、详细步骤

友情提示：

 - 打开对象库：View ➪ Utilities ➪ Show Object Library
 - 显辅助视图：View ➪ Assistant Editor Show Assistant Editor
 - 显示源代码视图：View ➪ Source Editor ➪ Show Standard Editor.

创建文件一个测试文件，就叫  `Adaptive` 工程好了:

![proj](http://ww2.sinaimg.cn/large/514b710agw1f33lg8d0q9j20ka0ee0tv.jpg)

打开 `Main.storyboard` ：

![storyboard](http://ww1.sinaimg.cn/large/514b710agw1f33lgrkbvfj20je0lumxc.jpg)

新建的storyboard **总是方方正正的**，这是xcode让你的注意力真正放在布局上，而不是某个特定的iphone/iPad尺寸；之后你在这个方方正正的容器里定义好各种 **尺寸约束** ，这样到时候页面就能自适应到各种iOS设备上了；

下面我们较为详细讲解如何给元素添加 **尺寸约束**

### 1.1、居中约束

在 **对象库** 中选中 label 组件并添加到 storyboard 中，**用鼠标调整至水平居中** 位置。

再在 storyboard 编辑器右下角选择 **alignment constraint editor（对齐约束编辑器）**，这里我们想让标签 **一直水平垂直居中** ，所以添加 **2个约束**

![constrait](http://ww4.sinaimg.cn/large/514b710agw1f33liirmobj20ic0dc401.jpg)

> 你可能注意总共有4种约束场景，分别是 **stack（选中两个组件才会出现）** 、 **align（常用的布局关系）** 、 **pin（相对布局方式）** 和 **Resolve Auto Layout Issues（用于校正自动布局问题）**

添加成功之后可以在左边场景视图中看到两个约束属性：

![constraint2](http://ww1.sinaimg.cn/large/514b710agw1f33ljkyo4sj209j07lwf8.jpg)

尝试选中其中一个，我们可以在 **属性检查器** 中更改约束（这个例子中不需要更改）:

![公式](http://ww3.sinaimg.cn/large/514b710agw1f33ll6dy7gj207709g3z0.jpg)

约束公式很简单：

```js
    Y = multiplier * X + constant
```

Y就是当前对象约束之后的值，X则是参考对象的值；


这里稍微解释一下 `leading` 和 `trailing` 两个单词的含义：

![书写顺序](http://ww4.sinaimg.cn/large/514b710agw1f33lm9xzrmj207i087jrx.jpg)

对于从左往右书写的国家（英语啊、中文啊大部分国家），这两个单词分别理解成 `left` 和 `right` 即可；而对于从右往左书写的国家（阿拉伯国家），这两个单词的理解恰好相反，需要理解成 `right` 和 `left`；



如果运行中提示 **Frame for “Label” will be different at run time.** 问题，可以通过 **Editor ➪ Resolve Auto Layout Issues ➪ Update Frames** 来更新解决之；

### 1.2、pin适应

接下来我们想在文本右边添加一个按钮，而且这个按钮位置√也能自动适应，这时候 **pin** 布局就派上用场了；

![pin](http://ww2.sinaimg.cn/large/514b710agw1f33ln45h8gj20f80cy0uf.jpg)

同样的，我们也可以选择约束项之后进行编辑；在编辑的时候，我们会发现xcode很智能地为我们自动适配要更改的属性，这里是水平距离对其的约束，这里约束的水平margin值为26（constant的值）

> 可以按住 `option` 键，可以像sketch那样快速获知当前组件的坐标位置


为了美观，我们还需要让button的字和label水平对其，这个时候又用到了对其约束：先 **同时选中** 两个组件，然后设置约束，可以看到xcode **很智能地会提取页面的值** 放到输入框中，最后添加约束即可；

![水平对其](http://ww1.sinaimg.cn/large/514b710agw1f33lt48ntxj20gy0bcabs.jpg)

最后为了让效果展现在storyboard上，需要点击一下 **Resolve Auto Layout Issues** 按钮刷新布局；

### 1.3、预览

为了不运行程序的情况下，我们可以在不同设备中检查布局是否自适应了；

打开 **辅助编辑器**（assitant editor），在 jump bar 上有一个 **布局预览**（layout preview）菜单就能查看：

![preview](http://ww4.sinaimg.cn/large/514b710agw1f33luaxeghj20jm0dnq59.jpg)

此时还可以通过 **左下角** 的 `+` 号添加其他型号的机型预览；

![multi](http://ww3.sinaimg.cn/large/514b710agw1f33lvi8hy4j20ct0jft9h.jpg)

## 2、Outlets

### 两种方式

首先，打开辅助编辑器。

创建outlets的方式有两种。一种是在组件上 **右键**，然后用鼠标按住弹出菜单项右边的圈圈，插入到要放置代码的地方：

![右键插入](http://ww2.sinaimg.cn/large/514b710agw1f3434q5fulj20jf0cowgg.jpg)

还有一种是快捷键方式 **Ctrl+Cmd+鼠标拖拽** ，因为这种方式比较快捷，推荐使用这种方式创建：

![快捷键插入](http://ww4.sinaimg.cn/large/514b710agw1f3436a9fkvj20le08xdhd.jpg)

在弹出的框里写入变量名称为 **UILabel**，然后点击 **connect** 按钮：

![写入变量名称](http://ww3.sinaimg.cn/large/514b710agw1f343amx0wpj20ih04rdgs.jpg)

这样在代码区就能自动获得代码：

```swift
@IBOutlet weak var textLabel: UILabel!
```

在代码界面上点击那个小圆点，就会在左边storybord上显示相关信息：

![显示相关信息](http://ww1.sinaimg.cn/large/514b710agw1f343qxfhrvj20jr09oaba.jpg)

### 创建actions

为了能够点击按钮之后 Label 组件内部的文本自动更改成 **Hello world**，需要给按钮 添加事件响应；

这里需要两个步骤，第一步创建按钮的outlets，过程上述创建label的过程一模一样，变量名为 **UIButton**；

第二步则是给这个按钮添加 actions ，创建方式和上面添加 outlets 的方式相一致，也是有右键和快捷键这两种方式；

在弹出的对话框里设置连接属性 为 **action**，定义的事件回调函数名称是 **onButtonPressed**，[UIButton](http://developer.apple.com/library/IOs/#documentation/UIKit/Reference/UIButton_Class/UIButton/UIButton.html) 按钮最常用的事件应该就是 **Touch Up Inside**：

![添加事件](http://ww2.sinaimg.cn/large/514b710agw1f343ukobrej20ip04vq4a.jpg)

这样就添加完成事件了，然后在里面写入代码逻辑，最后具体的代码是：
```swift

    @IBOutlet weak var someButton: UIButton!
    @IBAction func onButtonPressed(sender: AnyObject) {
        textLabel.text = "Hello World"
    }
```

最后点击运行程序，用户在点击按钮之后就会将 label 文本修改成 Hello World 了；完成~


