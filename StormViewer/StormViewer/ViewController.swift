//
//  ViewController.swift
//  StormViewer
//
//  Created by Tom Holland on 4/29/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa

class ViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sharedClick(_ sender: NSView) {
        guard let detail = childViewControllers[1] as? DetailViewController else { return }
        guard let image = detail.imageView.image else { return }
        
        let picker = NSSharingServicePicker(items: [image])
        picker.show(relativeTo: .zero, of: sender, preferredEdge: .minY)
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

