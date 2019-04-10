# 基本介绍

## 命令行初始化

在某个空白文件夹下，通过 `swift package init` 就能生成一个默认的包，这个包里就带了源码和相应的测试代码；

![初始化目录](https://ws1.sinaimg.cn/large/006tKfTcgy1fhrrkjeedvj30p90bnwfj.jpg)


在 **Sources/swift_test_intro.swift** 是自动生成的代码：

> 这里的是 `swift_test_intro` 名字是我刚才新建的文件夹名

```js
struct swift_test_intro {

    var text = "Hello, World!"
}
```

经典的 Hello, Wrold，在 **Tests/swift-test-introTests/swift_test_introTests.swift** 文件中包含了对应的测试文件：

```js
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(swift_test_intro().text, "Hello, World!")
    }
```


![测试文件](https://ws2.sinaimg.cn/large/006tKfTcgy1fhrrnntmnzj30uv0cl76k.jpg)

然后在命令行中执行 `swift test` 就能看到测试结果了；

## 在IDE中进行测试

### 建立一个应用

我们首先创建一个名为 **Calculator** （计算器）的应用

![创建](https://ws3.sinaimg.cn/large/006tKfTcgy1fhrsbfl6hkj30ka0emq49.jpg)


![Calculator](https://ws1.sinaimg.cn/large/006tKfTcgy1fhrsd4y4aoj30ka0em756.jpg)

注意这里需要勾选 **include Unit Tests** 和 **include UI Tests**

在然后在工程中添加新的 Swift 文件；
![add file](https://ws4.sinaimg.cn/large/006tKfTcgy1fhrsgqq3ibj30ka0emdh1.jpg)


名字为 **CalculatorModel.swift**，我们所做的单元测试就是针对这个文件进行的；

然后我们搭建一个简单的应用：

 1. 在 Project Navigator, 点击 **Main.storyboard** 文件

 2. 在 Object Library 中搜索 Text Field 组件 .

 3. 然后拖拽组件放在 Storyboard 上
   - 2 个 **Text fields** 
   - 1 个 **Button**
   - 1 个 **Label**
 
 4. 然后更改一下样式和文字，弄成下面那个样子

![界面](https://ws3.sinaimg.cn/large/006tKfTcgy1fhrtb3hdqvj30cc0hvwel.jpg)

打开辅助视图，我们为之创建 **Outlet** 和 **IBAction** ，编写一下逻辑代码，更改之后的 **ViewController.swift** 文件长这样 

```js
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputA: UITextField!
    @IBOutlet weak var inputB: UITextField!
    @IBOutlet weak var resultText: UILabel!

    ...

    @IBAction func onClickAdd(_ sender: UIButton) {
        resultText.text = String(resultCalc.add(
            a: Int((inputA.text! as NSString).intValue),
            b: Int((inputB.text! as NSString).intValue)
        ))
    }

}

```

### 编写测试用例

随后我们打开 **CalculatorTests/CalculatorTests.swift** 文件夹，然后编写测试用例：

```js
import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    let resCalc = Calculator(a:0, b:0)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertEqual(resCalc.add(a: 1, b: 2), 3)
        XCTAssertEqual(resCalc.sub(a: 4, b: 2), 2)
        XCTAssertEqual(resCalc.multi(a: 3, b: 4), 12)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
```

切换到 **测试用例导航** （第5个位置）

![测试视图](https://ws4.sinaimg.cn/large/006tKfTcgy1fhrt2m1xscj307c05aq33.jpg)

点击运行就可以了；
