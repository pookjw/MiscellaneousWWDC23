//
//  EmptyViewController.swift
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/19/23.
//

import AppKit

@MainActor
@objc
final class EmptyViewController: NSViewController {
    @ViewLoading private var textField: NSTextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField: NSTextField = .init(frame: view.bounds)
        textField.isEditable = false
        textField.isSelectable = false
        textField.isBezeled = false
        textField.preferredMaxLayoutWidth = .zero
        textField.lineBreakMode = .byWordWrapping
        textField.drawsBackground = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.stringValue = "No Selection"
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.textField = textField
    }
}
