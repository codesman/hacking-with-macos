//: Playground - noun: a place where people can play

import Cocoa

var someSet = Set<String>()

var anotherSet: Set<String> = ["Value1", "Value2"]

var typeInferredSet: Set = ["Value1", "Value2"]

var typeInferredArray = ["Value1", "Value2"]


var appleProducts: Set = ["iMac", "MacBook Pro", "iPhone"]

var countries = ["Albania", "Brail", "China", "China"]

appleProducts.count
appleProducts.first

appleProducts.insert("AppleTV")

appleProducts

if let removedProduct = appleProducts.remove("AppleTV") {
    print("\(removedProduct) sold")
} else {
    print("Kept it")
}

var divisibleBy2: Set = [2, 4, 8, 10]
var divisibleBy3: Set = [3, 6, 9, 12, 15]
var divisibleBy4: Set  = [4, 8, 12, 16, 20]

divisibleBy2.intersection(divisibleBy3).sorted()
divisibleBy2.symmetricDifference(divisibleBy4).sorted()
divisibleBy2.isSubset(of: divisibleBy4)
divisibleBy2.isSuperset(of: divisibleBy3)
divisibleBy2.isDisjoint(with: divisibleBy3)


