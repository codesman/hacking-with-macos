//: Playground - noun: a place where people can play

import Cocoa

@objc protocol Palindrome {
    @objc optional func palindromeCheck(word: String) -> Bool
    var numberOfWords: Int { get } // readOnly
    var numberOfCharacters: Int { get set } // readWrite
    
    static var longestPalindrome: String { get } // readOnly
}

class FunWithWords: Palindrome {
    func oxymorons() {
        print("I find it SERIOUSLY FUNNY that its SIMPLY IMPOSSIBLE to find an EXACT COPY of the class syllabus.  I'll try asking one of the PAID VOLUNTEERS at the library")
    }
    
    @objc func palindromeCheck(word: String) -> Bool {
        var reverseString = ""
        
        for character in word.characters {
            reverseString = String(character) + reverseString
        }
        
        return reverseString.replacingOccurrences(of: " ", with: "").lowercased()
            == word.replacingOccurrences(of: " ", with: "")
    }
    
    @objc var numberOfCharacters: Int = 0
    @objc var numberOfWords: Int = 0
    @objc static var longestPalindrome: String = "Gateman sees name, garageman sees nametag."
    
}

var palindromeOrNot = FunWithWords()

palindromeOrNot.palindromeCheck(word: "doood")

FunWithWords.longestPalindrome
