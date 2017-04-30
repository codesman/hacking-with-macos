//: Playground - noun: a place where people can play

import Cocoa

struct StackOfObjects <Element> {
    var objects = [Element]()
    
    mutating func pushOnTheStack(object: Element) {
        objects.append(object)
    }
    
    mutating func popOffTheStack(object: Element) -> Element {
        return objects.removeLast()
    }
}

var stringStack = StackOfObjects<String>()

stringStack.pushOnTheStack(object: "One")
stringStack.pushOnTheStack(object: "Two")
stringStack.objects

stringStack.popOffTheStack(object: "One")
stringStack.objects

var intStack = StackOfObjects<Int>()

intStack.pushOnTheStack(object: 3)
intStack.pushOnTheStack(object: 4)
intStack.pushOnTheStack(object: 5)
intStack.objects

intStack.popOffTheStack(object: 5)
intStack.objects

extension StackOfObjects {
    var topOfStack: Element? {
        return objects.isEmpty ? nil : objects[objects.count - 1]
    }
}

if let topObject = intStack.topOfStack {
    print("The top object on the stack is \(topObject)")
}

intStack.topOfStack



func swapTwoValues<T>(value1: inout T, value2: inout T ) {
    let temp = value1
    value1 = value2
    value2 = temp
}

var intValue1 = 45
var intValue2 = 250

swapTwoValues(value1: &intValue1, value2: &intValue2)

intValue1
intValue2


var uppercaseString = "UPPERCASE"
var lowercaseString = "lowercase"

swapTwoValues(value1: &uppercaseString, value2: &lowercaseString)

uppercaseString
lowercaseString


var firstNamesArray = ["joe", "john", "jim"]
var lastNamesArray = ["smith", "baker", "jones"]

swapTwoValues(value1: &firstNamesArray, value2: &lastNamesArray)

firstNamesArray
lastNamesArray




