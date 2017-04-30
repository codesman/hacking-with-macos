//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Tom Holland on 4/29/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {
    @IBOutlet var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imageSelected(name: String) {
        imageView.image = NSImage(named: name)
    }
}
