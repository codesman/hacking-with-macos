//: Playground - noun: a place where people can play

import Cocoa

var meeting = (name: "Board Meeting", date: NSDate(), bool: true)
var currency = (symbol: "USD", 350.00)

meeting.name
currency.symbol

meeting.1

let (symbol, amount) = currency

symbol
amount

let businessTrips = [
    "San Francisco": 650,
    "Japan": 1000,
    "London": 1200,
    "Brazil": 2200,
    "New York": 450
]

for (location, expense) in businessTrips {
    print("The trip to \(location) cost $\(expense)")
}

func smallestAndLargest(arrayOfInts: [Int]) -> (small: Int, large: Int)? {
    guard !arrayOfInts.isEmpty else { return nil }
    
    var smallest = arrayOfInts[0]
    var largest = arrayOfInts[0]
    
    for value in arrayOfInts[1..<arrayOfInts.count] {
        if value < smallest {
            smallest = value
        } else if value > largest {
            largest = value
        }
    }
    
    return (smallest, largest)
}

//let myArray = [1,2,3,4,5,6,90]
//
//let value = smallestAndLargest(arrayOfInts: myArray)
//
//value.large
//value.small
//
//
//let (smallest, largest) = smallestAndLargest(arrayOfInts: myArray)
//smallest
//largest


var emptyArray = [Int]()

if let optionalResults = smallestAndLargest(arrayOfInts: emptyArray) {
    print("Smallest: \(optionalResults.small), Largest: \(optionalResults.large))")
}





