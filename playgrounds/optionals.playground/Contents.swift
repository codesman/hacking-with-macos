//: Playground - noun: a place where people can play

import Cocoa

var optionalString: String?

optionalString = "Unwrap me please!"

func unwrap(input: String?) -> String {
    guard let unwrapped = input else { return "" }
    
    return unwrapped
}

let unwrappedString: String = unwrap(input: optionalString)
