# 面向协议开发

 - [Protocol Oriented Programming in Swift](http://rshankar.com/protocol-oriented-programming-in-swift/)：入门教程，来自 **rshankar** 网站；本文原始内容翻译于此
 - [Protocol-Oriented Programming in Swift 2](http://code.tutsplus.com/tutorials/protocol-oriented-programming-in-swift-2--cms-24979)：tutsplus文章，内容和上篇大同小异；
 - [Introducing Protocol-Oriented Programming in Swift 2](https://www.raywenderlich.com/109156/introducing-protocol-oriented-programming-in-swift-2)：内容也相差不多


## 协议（Protocols）和结构体（Structs）

以交通工具为例，我们讲解如何使用协议和结构体来创建 `Bicylce`, `MotorBike` 和 `Car` 三个类；

首先创建两个协议， `Vehicle` 和 `MotorVehicle`，分别定义如下：

**Vehicle** 是最基础的，是普通交通工具都有的属性：
```swift
protocol Vehicle {
    var speed: Int {get}
    var color: String {get}
    var yearOfMake: Int {get}
}
```

  - speed：车速
  - color：颜色值
  - yearOfMake：车辆生产日期

**MotorVehicle** 则是更近一步，涉及电动车辆的属性：
```swift
protocol MotorVehicle {
    var engineSize: Int {get}
    var licensePlate: String {get}
}
```
  - engineSize：发动机型号
  - licensePlate：机动车牌照

**在swift中，任何类型都能实现Protocol协议**，我们通常更倾向于使用 **Struct** 来实现协议，这是因为Struct是 **值类型**，能够避免继承的潜在含义；而且值类型相比引用类型（Class）能更少地遇到内容方面的issue；

```swift
struct Bicyle: Vehicle {
    let speed: Int
    let color: String
    let yearOfMake: Int
}
 
struct MotorBike: MotorVehicle, Vehicle {
    let speed: Int
    let color: String
    let engineSize: Int
    let licensePlate: String
    let yearOfMake: Int
}
struct Car: MotorVehicle, Vehicle  {
    let speed: Int
    let color: String
    let engineSize: Int
    let licensePlate: String
    let numberOfDoors: Int
    let yearOfMake: Int
}

```

 - 我们创建了3中交通工具：自行车（Bicyle）、电动车（MotorBike）和汽车（Car）
 - 自行车仅仅实现了 `Vehicle` 协议；电动车和汽车实现了 `Vehicle` 和 `MotorVehicle` 协议

接下来，我们就可以创建实例了：

```swift
let cycle = Bicyle(speed: 10, color: "Blue",yearOfMake: 2011)
let bike = MotorBike(speed: 65, color: "Red", engineSize: 100, licensePlate: "HT-12345",yearOfMake: 2015)
let bmw = Car(speed: 220, color: "Green", engineSize: 1200, licensePlate: "FC-20 435", numberOfDoors: 4,yearOfMake: 2016)
let audi = Car(speed: 220, color: "Cyan", engineSize: 1200, licensePlate: "FC-41 234", numberOfDoors: 4,yearOfMake: 2013)
```

## 协议扩展（Protocol Extension）

在swift2.0中，协议（Protocol）真正强大的地方在于能够添加扩展（Extension），这样协议 **不仅仅是规定方法标准，而且还具有了提供具体方法的能力**；

比如最简单的需求：**基于制造年份比较车辆新旧**

你现在只需要做的就是给协议添加一个扩展：
```swift
extension Vehicle {
    func isNewer(item: Vehicle) -> Bool {
        return self.yearOfMake > item.yearOfMake
    }
}
```

这样我们就能比较得出奥迪（audi）比宝马（bmw）要旧一些了：
```swift
// comparing audi and bmw should return false
audi.isNewer(bmw)
```

## 给Swift标准库加扩展

你可以给Swift标准库（Swift standard library）比如 `CollectionType` 、 `Range` 、`Array`等添加扩展功能；

比如有这么一个场景：你有很多电动车，然后数据以数组形式存放在数组里：

```swift
let bike1 = MotorBike(speed: 65, color: "Red", engineSize: 100, licensePlate: "HT-12345",yearOfMake: 2015)
let bike2 = MotorBike(speed: 75, color: "Black", engineSize: 120, licensePlate: "RV-453",yearOfMake: 2013)
let bike3 = MotorBike(speed: 55, color: "Blue", engineSize: 80, licensePlate: "XY-5 520",yearOfMake: 2012)
let bike4 = MotorBike(speed: 55, color: "Red", engineSize: 80, licensePlate: "XY-7 800",yearOfMake: 2009)
 
let motorbikes = [bike1,bike2, bike3, bike4]
```

此时你想根据 **licensePlate** 信息过滤车辆，筛选出车牌号包含 “XY” 字母的车辆，此时给 `CollectionType`添加扩展，当然 **只针对实现MotorVehicle协议的元素** ；扩展的方法名为 `filterLicensePlate`，实现代码如下：

```swift
xtension CollectionType where Generator.Element:MotorVehicle {
    func filterLicensePlate(match:String -&gt; [Generator.Element] {
        var result:[Generator.Element] = []
        for item in self {
            if item.licensePlate.containsString(match) {
                result.append(item)
            }
        }
        return result
    }
}
```

然后就能用了：

```swift
let motorbikes = [bike1,bike2, bike3, bike4]
// fiter only small mopeds based on XY
motorbikes.filterLicensePlate("XY").count
```


