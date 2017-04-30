//: Playground - noun: a place where people can play

import Cocoa

extension Int {
    var feetInMile: Int { return self * 5280 }
    var inchInMile: Int { return self * 63360 }
}

let marathonFeet = 26.feetInMile
let marathonInches = 26.inchInMile

print("There are \(marathonFeet) feet or \(marathonInches) in a Marathon")