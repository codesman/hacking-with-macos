//
//  ViewController.swift
//  CowsAndBulls
//
//  Created by Tom Holland on 4/30/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa
import GameplayKit

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var answer = ""
    var guesses = [String]()

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {
            return nil
        }
        
        if tableColumn?.title == "Guess" {
            // Guess Column
            view.textField?.stringValue = guesses[row]
        } else {
            // Result Columns
            view.textField?.stringValue = result(for: guesses[row])
        }
        
        return view
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func startNewGame(){
        guess.stringValue = ""
        guesses.removeAll()
        answer = ""
        
        var numbers = Array(0...9)
        
        numbers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbers) as! [Int]
        
        for _ in 0..<4 {
            answer.append(String(numbers.removeLast()))
        }
        
        tableView.reloadData()
    }
    
    func result(for guess: String) -> String {
        
        var bulls = 0
        var cows = 0
        
        let guessLetters = Array(guess.characters)
        let answerLetters = Array(answer.characters)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                cows += 1
            }
        }
        
        return "\(bulls)b \(cows)c"
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func submitGuess(_ sender: Any) {
        
        // Check for 4 unique characters
        let guessString = guess.stringValue
        guard Set(guessString.characters).count == 4 else { return }
        
        // Ensure there are no non-digit characters
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
        
        // Add the guess to array & table view
        guesses.insert(guessString, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        // Determine win/lose
        let resultString = result(for: guessString)
        
        // Alert status if won
        if resultString.contains("4b") {
            let alert = NSAlert()
            alert.messageText = "You Win!"
            alert.informativeText = "Congratulations! Click OK to play again"
            
            alert.runModal()
            startNewGame()
        }
        
    }
}

