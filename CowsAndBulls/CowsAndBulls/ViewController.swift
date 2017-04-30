//
//  ViewController.swift
//  CowsAndBulls
//
//  Created by Tom Holland on 4/30/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var answer = ""
    var guesses = [String]()

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
//        if tableColumn?.identifier == "Result" {
//            // Result Column
//            view.textField?.stringValue = result(for: guesses[row])
//        }
        
        return view
    }
    
    func result(for guess: String) -> String {
        return "Result"
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

