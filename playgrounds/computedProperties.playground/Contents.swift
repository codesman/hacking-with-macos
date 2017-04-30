//: Playground - noun: a place where people can play

import Cocoa

struct Math {
    var width = 10.0
    var height = 10.0
    
    var area: Double {
        get {
            return width * height
        }
        set(newArea) {
            let squareRoot = sqrt(newArea)
            width = squareRoot
            height = squareRoot
        }
    }
}

var squared = Math.init(width: 12.0, height: 12.0)
squared.area

squared.area = 25
squared.width
squared.height

squared.area