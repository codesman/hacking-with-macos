//: Playground - noun: a place where people can play

import Cocoa

class Book {
    var title: String
    init(title: String) {
        self.title = title
    }
}

class Fiction: Book {
    var author: String
    init(title: String, author: String) {
        self.author = author
        super.init(title: title)
    }
}

class NonFiction: Book {
    var publishedBy: String
    init(title: String, publishedBy: String) {
        self.publishedBy = publishedBy
        super.init(title: title)
    }
}

let bookLibrary = [
    Fiction(title: "My Book", author: "Myself J. Selfington"),
    NonFiction(title: "True Dat!", publishedBy: "Some Dude")
]

var fictionCount = 0
var nonFictionCount = 0

for book in bookLibrary {
    if book is Fiction {
        fictionCount += 1
    } else if book is NonFiction{
        nonFictionCount += 1
    }
}

for book in bookLibrary {
    if let fiction = book as? Fiction {
        print("Fiction: \(fiction.title), by: \(fiction.author)")
    } else if let nonFiction = book as? NonFiction {
        print("NonFiction: \(nonFiction.title), by: \(nonFiction.publishedBy)")
    }
}

var bookObjects: [AnyObject] = [
    Fiction(title: "My Book", author: "Myself J. Selfington"),
    Fiction(title: "My Book", author: "Myself J. Selfington")
]


for book in bookObjects {
    let fiction = book as! Fiction
    print("Fiction: \(fiction.title) - Author: \(fiction.author)")
}

for fiction in bookObjects as! [Fiction] {
     print("Fiction: \(fiction.title) - Author: \(fiction.author)")
}

var variousItems = [Any]()

variousItems.append("My String")
variousItems.append(24)
variousItems.append(0.0)
variousItems.append((10, 30))
variousItems.append(Fiction(title: "My Book", author: "Myself J. Selfington"))
variousItems.append(NonFiction(title: "True Dat!", publishedBy: "Some Dude"))
variousItems.append({ (name: String) -> String in "Hello, \(name)"})

variousItems

for items in variousItems {
    switch items {
    case 24 as Int:
        print("A Int value of 24 is in the array")
    case 0.0 as Double:
        print("A Double value of 0.0 is in the array")
    case let someInt as Int:
        print("An Int value of \(someInt) is in the array")
    case let someDouble as Double where someDouble > 0:
        print("A Double value of \(someDouble) is in the array")
    case is Double:
        print("Some other Double")
    case let someString as String:
        print("A string value of \(someString)")
    case let (x, y) as (Double, Double):
        print("An (x, y) point at (\(x),\(y))")
    case let fiction as Fiction:
        print("Fiction: \(fiction.title), by: \(fiction.author)")
    case let stringClosure as (String) -> String:
        print(stringClosure("John"))
    default:
        print("default string")
    }
}






