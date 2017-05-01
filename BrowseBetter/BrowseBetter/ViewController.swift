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
        
        if sender.selectedSegment == 0 {
            // Need to add a row
            let columnCount = (rows.arrangedSubviews[0] as! NSStackView).arrangedSubviews.count
            let viewArray = (0 ..< columnCount).map { _ in makeWebView() }
            let row = NSStackView(views: viewArray)
            
            row.distribution = .fillEqually
            rows.addArrangedSubview(row)
        } else {
            // Need to delete a row
            guard rows.arrangedSubviews.count > 1 else { return }
            guard let rowToRemove = rows.arrangedSubviews.last as? NSStackView else { return }
            
            for cell in rowToRemove.arrangedSubviews {
                cell.removeFromSuperview()
            }
            
            rows.removeArrangedSubview(rowToRemove)
        }
    }
    
    @IBAction func adjustColumns(_ sender: NSSegmentedControl) {
        
        if sender.selectedSegment == 0 {
            // Add a column
            for case let row as NSStackView in rows.arrangedSubviews {
                row.addArrangedSubview(makeWebView())
            }
        } else {
            // Need to delete a column
            // Get the first row
            guard let firstRow = rows.arrangedSubviews.first as? NSStackView else { return }
            
            // Make sure the row has at least 2 columns
            guard firstRow.arrangedSubviews.count > 1 else { return }
            
            // We've got a column that can be deleted
            for case let row as NSStackView in rows.arrangedSubviews {
                if let last = row.arrangedSubviews.last {
                    row.removeArrangedSubview(last)
                    last.removeFromSuperview()
                }
            }
        }
    }
    
    func makeWebView() -> NSView {
        let webView  = WKWebView()
        webView.navigationDelegate = self
        webView.wantsLayer = true
        
        webView.load(URLRequest(url: URL(string: "https://www.apple.com")!))
        
        return webView
    }
}

