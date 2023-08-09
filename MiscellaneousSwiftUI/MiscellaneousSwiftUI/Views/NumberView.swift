//
//  NumberView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/8/23.
//

import SwiftUI
import Combine

struct NumberView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ContentViewController {
        .init()
    }
    
    func updateUIViewController(_ uiViewController: ContentViewController, context: Context) {
        
    }
    
    @MainActor
    final class ContentViewController: UIViewController {
        private var viewModel: NumberViewModel? = .init()
        private var task: Task<Void, Never>?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let action: UIAction = .init { _ in
                let selector: Selector = #selector(self.viewDidLoad)
            }
            
            let incrementButton: UIButton = .init(primaryAction: .init(title: "Increment", handler: { [weak viewModel] _ in
                let selector: Selector = #selector(self.viewDidLoad)
                viewModel?.number += 1
            }))
            
            let cancelButton: UIButton = .init(primaryAction: .init(title: "Cancel", handler: { [weak self] _ in
                self?.task?.cancel()
            }))
            
            let deinitViewModelButton: UIButton = .init(primaryAction: .init(title: "Deinit", handler: { [weak self] _ in
                self?.viewModel = nil
            }))
            
            let stackView: UIStackView = .init()
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
            stackView.addArrangedSubview(incrementButton)
            stackView.addArrangedSubview(cancelButton)
            stackView.addArrangedSubview(deinitViewModelButton)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            task = .init { [weak viewModel] in
                for await number in await viewModel!.numberStream {
                    print(number)
                }
            }
        }
        
        deinit {
            task?.cancel()
        }
    }
}
