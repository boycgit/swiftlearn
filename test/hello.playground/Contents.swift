//: Playground - noun: a place where people can play

import UIKit


class A {
    var i: Int
    init(aInt: Int) {
        self.i = aInt;
        
    }
    
    var intValue:Int {
        set(newValue){
            self.i = newValue
        }
        
        get{
            return self.i
        }
    }
}

func changeIntValue(a:A){
    a.intValue = 999
}

var a:A = A(aInt: 10)

func returnInt() -> Int? {
    return nil;
}

var str:String? = "String";
print(str!)

func method(paraName para:Int) {
    print(para)
}
method(paraName: 10)

let x:Int? = 10;

func guardMethod(){
    guard let b:Int = x else {
        print(x)
        return
    }
}

func getCode()->(statusCode:Int, message: String){
    return(statusCode: 404, message: "Not Found")
}
getCode()

var dict: Dictionary<Int, Int> = [:]
var array:Array<Int> = []


