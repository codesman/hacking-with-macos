//: Playground - noun: a place where people can play

import Cocoa

enum DogBreed  {
    case pomeranian ( Int, String )
    case husky ( Int, String )
    case pug ( Int, String )
    case collie ( Int, String )
}

enum State {
    case newYork, florida, newJersey, california, texas, georgia
}

enum FirstName: String {
    case rob, john, tom, rich
}

let name = FirstName.rob.rawValue



enum ControlCharacter: Character {
    case tab = "\t"
    case linefeed = "\n"
    case carriageReturn = "\r"
}

let tab = ControlCharacter.tab.rawValue
let linefeed = ControlCharacter.linefeed.rawValue
let carriageReturn = ControlCharacter.carriageReturn.rawValue



indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}


func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
        
    case .number(let value):
        return value
        
    case .addition(let left, let right):
        return evaluate(expression: left) + evaluate(expression: right)
        
    case .multiplication(let left, let right):
        return evaluate(expression: left) * evaluate(expression: right)
        
    default:
        return 0
    }
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

print(evaluate(expression: product))



enum MovieGenre: Int {
    case action = 1,
    comedy,
    drama,
    scienceFiction,
    fantasy,
    classics,
    foreign,
    documentary
}

let genre = MovieGenre.drama.rawValue
let favoriteGenre = MovieGenre(rawValue: 4)

let movieGenreToFind = 15

if let someGenre = MovieGenre(rawValue: movieGenreToFind) {
    switch someGenre {
    case .classics:
        print("Found genre at position \(movieGenreToFind)")
    default:
        print("Found no genres at position \(movieGenreToFind)")
    }
} else {
    print("There is no genre at position \(movieGenreToFind)")
}



enum ATMError: Error {
    case invalidSelection
    case updatedBankBalance(addFunds: Double)
    case wrongPinNumber
    case balanceCheck(alert: String)
}


var bankBalance = 400.0

func balanceCheckIfBelow500() {
    if bankBalance < 500 {
        ATMError.balanceCheck(alert: "Your account is overdrawn")
    }
}

func addFunds(add: Double) -> ATMError {
    return ATMError.updatedBankBalance(addFunds: bankBalance + add)
}

balanceCheckIfBelow500()
addFunds(add: 230.0)



var lifespanAndCategory = DogBreed.pug(17, "Toy Breed")

switch lifespanAndCategory {
case .pomeranian(let lifespan, let category):
    print("Pomeranians live to about \(lifespan), and are a \(category)")
    
case .husky(let lifespan, let category):
    print("Huskies live to about \(lifespan), and are a \(category)")
    
case .pug(let lifespan, let category):
    print("Pugs live to about \(lifespan), and are a \(category)")
    
case .collie(let lifespan, let category):
    print("Collies live to about \(lifespan), and are a \(category)")
    
default:
    print("No Match")
}

