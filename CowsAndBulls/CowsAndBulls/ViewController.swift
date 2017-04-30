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
        
        if tableColumn?.identifier == "Guess" {
            // Guess Column
            view.textField?.stringValue = result(for: guesses[row])
        }
        
        return view
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
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}

