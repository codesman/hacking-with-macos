//
//  WindowController.swift
//  StormViewer
//
//  Created by Tom Holland on 4/30/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet var shareButton: NSButton!
    @IBOutlet var messageButton: NSButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
       shareButton.sendAction(on: .leftMouseDown)
    }

    @IBAction func sharedClick(_ sender: NSView) {
        guard let split = contentViewController as? NSSplitViewController else { return }
        guard let detail = split.childViewControllers[1] as? DetailViewController else { return }
        guard let image = detail.imageView.image else { return }
        let picker = NSSharingServicePicker(items: [image])
        picker.show(relativeTo: .zero, of: sender, preferredEdge: .minY)
    }
    
    @IBAction func messageClicked(_ sender: NSView) {
        let alert = NSAlert()
        alert.messageText = "You are killing it man!"
        alert.informativeText = "macOS development ForTheWin!"
        
        alert.runModal()
    }
    @IBAction func aboutClicked(_ sender: Any) {
        
        let options = [String: Any]()
        
        let app = NSApplication.shared()
        app.orderFrontStandardAboutPanel(options: options)
        
    }
}
