//: Playground - noun: a place where people can play

import Cocoa

func swapTwoNumbers(num1: inout Int, num2: inout Int) {
    let temp = num1
    num1 = num2
    num2 = temp
}

var valueOne = 35
var valueTwo = 54

swapTwoNumbers(num1: &valueOne, num2: &valueTwo)

print("valueOne is now \(valueOne), and valueTwo is now \(valueTwo)")


