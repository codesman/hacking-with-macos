//: Playground - noun: a place where people can play

import Cocoa

class MyBank {
    var bankBalance: Double = 0.0 {
        willSet(newBalance) {
            print("About to set account to  \(newBalance)")
        }
        
        didSet(oldBalance) {
            bankBalance > oldBalance
                ? print("Deposit: \(bankBalance - oldBalance)")
                : print("Withdrawal: \(oldBalance - bankBalance)")
        }
    }
}

var bank = MyBank()
bank.bankBalance = 234

bank.bankBalance = 300

bank.bankBalance = 100

