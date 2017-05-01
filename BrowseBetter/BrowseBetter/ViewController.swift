//
//  ViewController.swift
//  BrowseBetter
//
//  Created by Tom Holland on 4/30/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate {
    
    var rows: NSStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add StackView
        rows = NSStackView()
        rows.orientation = .vertical
        rows.distribution = .fillEqually
        rows.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rows)
        
        // Define Autolayout Constraints
        rows.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rows.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rows.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rows.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Initial Column View
        let column = NSStackView(views: [makeWebView()])
        column.distribution = .fillEqually
        
        // Add Column to rows Stack View
        rows.addArrangedSubview(column)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func urlEntered(_ sender: NSTextField) {
        
    }

    @IBAction func navigationClicked(_ sender: NSSegmentedControl) {
        
    }
    
    @IBAction func adjustRows(_ sender: NSSegmentedControl) {
        
    }
    
    @IBAction func adjustColumns(_ sender: NSSegmentedControl) {
        
    }
    
    func makeWebView() -> NSView {
        let webView  = WKWebView()
        webView.navigationDelegate = self
        webView.wantsLayer = true
        
        webView.load(URLRequest(url: URL(string: "https://www.apple.com")!))
        
        return webView
    }
}

