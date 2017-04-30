//
//  ViewController.swift
//  CowsAndBulls
//
//  Created by Tom Holland on 4/30/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func submitGuess(_ sender: Any) {
    }
}

