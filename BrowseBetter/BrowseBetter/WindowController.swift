//
//  WindowController.swift
//  BrowseBetter
//
//  Created by Tom Holland on 5/1/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet var addressEntry: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.titleVisibility = .hidden
    }

    override func cancelOperation(_ sender: Any?) {
        window?.makeFirstResponder(self.contentViewController)
    }
}
