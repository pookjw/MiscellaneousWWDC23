//
//  UIKitSwiftDemoViewController.swift
//  MiscellaneousTipKit
//
//  Created by Jinwoo Kim on 7/28/23.
//

import UIKit
import SwiftUI

struct UIKitSwiftDemoViewController_SwiftUI: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitSwiftDemoViewController {
        .init()
    }
    
    func updateUIViewController(_ uiViewController: UIKitSwiftDemoViewController, context: Context) {
        
    }
}

@MainActor
final class UIKitSwiftDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
    }
    
    func _dismiss() {
        if let presentedViewController {
            presentedViewController.dismiss(animated: true)
        }
        
        dismiss(animated: true)
        
        //
        
        while let presentedViewController {
            presentedViewController.dismiss(animated: true)
        }
        
        dismiss(animated: true)
    }
}
