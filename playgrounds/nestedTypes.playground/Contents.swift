//: Playground - noun: a place where people can play

import Cocoa

class Email {
    
    enum Status {
        case read, unread, sent, received
    }
    
    let sender: String
    let recipient: String
    let date: NSDate
    
    var status = Status.sent
    
    var urgent = Priority()
    var important = Priority()
    var notImportant = Priority()
    
    init(sender: String, recipient: String) {
        self.sender = sender
        self.recipient = recipient
        self.date = NSDate()
    }
    
    func summary() -> String {
        return "Sent From: \(sender), Recipient: \(recipient), Time: \(date)"
    }
    
    func state() -> String {
        switch status {
        case .read:
            return "Email Read!"
        case .unread:
            return "Email has not been read!"
        case .sent:
            return "Email has been sent!"
        case .received:
            return "Email has been received!"
        }
    }
    
    class Priority {
        
        var someSpam = Spam()
        
        class Spam {
            enum DeletionTimeForSpam: Int {
                case deleteAfter1Day = 1
                case deleteAfter5Days = 5
                case deleteAfter10Days = 10
            }
            
            var delete = DeletionTimeForSpam.deleteAfter5Days
        }
    }
    
//    class EmailPriority {
//        class Spam {
//            enum Favorite {
//                struct Work {
//                }
//            }
//        }
//    }
}

var myEmail = Email(sender: "Bill Smith", recipient: "Joe Mosley")
myEmail.summary()
myEmail.state()
myEmail.important.someSpam.delete

