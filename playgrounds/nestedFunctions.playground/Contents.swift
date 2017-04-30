//: Playground - noun: a place where people can play

import Cocoa

func choseStepFunction(backwards: Bool) -> (Int) -> (Int) {
    
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    return backwards ? stepBackward : stepForward
}

var currentValue = 20
let moveNearerToZero = choseStepFunction(backwards: currentValue > 0)

while currentValue != 0 {
    print("\(currentValue)")
    currentValue = moveNearerToZero(currentValue)
}
