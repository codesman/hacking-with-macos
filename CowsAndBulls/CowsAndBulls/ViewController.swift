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
    
    enum Skill {
        case low(Int)
        case medium(Int)
        case high(Int)
    }
    
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
    
    func calculateSkill(with guesses: Int) -> Skill {
        
        var skill = Skill.low(guesses)
        
        if (1...3).contains(guesses) {
            skill = Skill.high(guesses)
        } else if (4...6).contains(guesses) {
            skill = Skill.medium(guesses)
        }
        
        return skill
    }
    
    func skillMessage(for skill: Skill) -> String {
        switch skill {
            
        case .high(let guesses):
            if guesses == 1 {
                return "Congratulations! You crushed it with only \(guesses) guess!"
            } else {
                return "Congratulations! you crushed it with only \(guesses) guesses!"
            }
        case .medium(let guesses):
            return "You did pretty well, \(guesses) guesses."
            
        case .low(let guesses):
            return "You could do better, \(guesses) guesses."
        }
    }
    
    @IBAction func submitGuess(_ sender: Any) {
        
        // Check for 4 unique characters
        let guessString = guess.stringValue
        guard Set(guessString.characters).count == 4 else { return }
        
        // Ensure there are no non-digit characters
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
        
        // Add the guess to array &s table view
        guesses.insert(guessString, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        // Determine win/lose
        let resultString = result(for: guessString)
        
        // Alert status if won
        if resultString.contains("4b") { // Found 4 Bulls
            
            let skill = calculateSkill(with: guesses.count)
            let skillMessage = self.skillMessage(for: skill)
            
            let alert = NSAlert()
            alert.messageText = "You Win!"
            alert.informativeText = "\(skillMessage) Click OK to play again"
            
            alert.runModal()
            startNewGame()
        }
    }
}

