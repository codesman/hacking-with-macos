//
//  ViewController.swift
//  BrowseBetter
//
//  Created by Tom Holland on 4/30/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate, NSGestureRecognizerDelegate, NSTouchBarDelegate, NSSharingServicePickerTouchBarItemDelegate {
    
    var rows: NSStackView!
    var selectedWebView: WKWebView!
    
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
        guard let selected = selectedWebView else { return }
        
        if let url = URL(string: sender.stringValue) {
            selected.load(URLRequest(url: url))
        }
    }
    
    @IBAction func navigationClicked(_ sender: NSSegmentedControl) {
        guard let selected = selectedWebView else { return }
        
        if sender.selectedSegment == 0 {
            selected.goBack()
        } else {
            selected.goForward()
        }
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
    
    func gestureRecognizer(_ gestureRecognizer: NSGestureRecognizer, shouldAttemptToRecognizeWith event: NSEvent) -> Bool {
        guard gestureRecognizer.view == selectedWebView else { return true }
        
        return false
    }
    
    func makeWebView() -> NSView {
        let webView  = WKWebView()
        webView.navigationDelegate = self
        webView.wantsLayer = true
        webView.load(URLRequest(url: URL(string: "https://www.apple.com")!))
        
        if selectedWebView == nil {
            select(webView: webView)
        }
        
//        2 ways to disambiguate clicks - number of clicks required or NSClickGestureRecognizerDelegate
//        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(webViewClicked))
//        recognizer.numberOfClicksRequired = 2
//        webView.addGestureRecognizer(recognizer)
        
        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(webViewClicked))
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
        
        return webView
    }
    
    func select(webView: WKWebView) {
        selectedWebView = webView
        selectedWebView.layer?.borderWidth = 4
        selectedWebView.layer?.borderColor = NSColor.blue.cgColor
        
        if let WindowController = view.window?.windowController as? WindowController {
            WindowController.addressEntry.stringValue = selectedWebView.url?.absoluteString ?? ""
        }
    }
    
    func webViewClicked(recognizer: NSClickGestureRecognizer) {
        guard let newSelectedWebView = recognizer.view as? WKWebView else { return }
        
        if let selected = selectedWebView {
            selected.layer?.borderWidth = 0
        }
        
        select(webView: newSelectedWebView)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        guard webView == selectedWebView else { return }
        
        if let WindowController = view.window?.windowController as? WindowController {
            WindowController.addressEntry.stringValue = selectedWebView.url?.absoluteString ?? ""
        }
    }
    
    @available(OSX 10.12.2, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItemIdentifier.enterAddress:
            let button = NSButton(title: "Enter a URL", target: self, action: #selector(selectedAddressEntry))
            let customTouchBarItem = NSCustomTouchBarItem(identifier: identifier)
            button.setContentHuggingPriority(10, for: .horizontal)
            customTouchBarItem.view = button
            
            return customTouchBarItem
            
        case NSTouchBarItemIdentifier.navigation:
            let back = NSImage(named: NSImageNameTouchBarGoBackTemplate)!
            let forward = NSImage(named: NSImageNameTouchBarGoForwardTemplate)!
            
            let segmentedControl = NSSegmentedControl(images: [back, forward], trackingMode: .momentary, target: self, action: #selector(navigationClicked))
            
            let customTouchBarItem = NSCustomTouchBarItem(identifier: identifier)
            customTouchBarItem.view = segmentedControl
            
            return customTouchBarItem
            
        case NSTouchBarItemIdentifier.sharingPicker:
            let picker = NSSharingServicePickerTouchBarItem(identifier: identifier)
            picker.delegate = self
            
            return picker
            
        case NSTouchBarItemIdentifier.adjustRows:
            let control = NSSegmentedControl(labels: ["Add Row", "Remove Row"], trackingMode: .momentaryAccelerator, target: self, action: #selector(adjustRows))
            let customTouchBarItem = NSCustomTouchBarItem(identifier: identifier)
            customTouchBarItem.customizationLabel = "Rows"
            customTouchBarItem.view = control
            
            return customTouchBarItem
            
        case NSTouchBarItemIdentifier.adjustCols:
            let control = NSSegmentedControl(labels: ["Add Column", "Remove Column"], trackingMode: .momentaryAccelerator, target: self, action: #selector(adjustColumns))
            let customTouchBarItem = NSCustomTouchBarItem(identifier: identifier)
            customTouchBarItem.customizationLabel = "Columns"
            customTouchBarItem.view = control
            
            return customTouchBarItem

            
        default:
            return nil
        }
    }
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        // Enable Touch Bar Customization
        NSApp.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = NSTouchBarCustomizationIdentifier("com.atomicappworks.browsebetter")
        touchBar.delegate = self
        
        // Set up defaults
        touchBar.defaultItemIdentifiers = [.navigation, .adjustGrid, .enterAddress, .sharingPicker]
        
        // Set address entry button to center
        touchBar.principalItemIdentifier = .enterAddress
        
        // Define customizable controls
        touchBar.customizationAllowedItemIdentifiers = [.sharingPicker, .adjustGrid, .adjustCols, .adjustRows]
        
        // Can not customize this item(s)
        touchBar.customizationRequiredItemIdentifiers = [.enterAddress]
        
        return touchBar

    }
    
    func selectedAddressEntry() {
        if let windowController = view.window?.windowController as? WindowController {
            windowController.window?.makeFirstResponder(windowController.addressEntry)
        }
    }
    
    @available(OSX 10.12.2, *)
    func items(for pickerTouchBarItem: NSSharingServicePickerTouchBarItem) -> [Any] {
        guard let webView = selectedWebView else { return [] }
        guard let url = webView.url?.absoluteString else { return [] }
        
        return [url]
    }
}

extension NSTouchBarItemIdentifier {
    static let navigation = NSTouchBarItemIdentifier("com.atomicappworks.browsebetter.navigation")
    static let enterAddress = NSTouchBarItemIdentifier("com.atomicappworks.browsebetter.enterAddress")
    static let sharingPicker = NSTouchBarItemIdentifier("com.atomicappworks.browsebetter.sharingPicker")
    static let adjustGrid = NSTouchBarItemIdentifier("com.atomicappworks.browsebetter.adjustGrid")
    static let adjustRows = NSTouchBarItemIdentifier("com.atomicappworks.browsebetter.adjustRows")
    static let adjustCols = NSTouchBarItemIdentifier("com.atomicappworks.browsebetter.adjustCols")
}
