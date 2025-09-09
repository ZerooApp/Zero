//
//  SplashScreenVC.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit
import Combine

final class SplashScreenVC: UIViewController {
    var viewModel: SplashScreenViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHosting(rootView: SplashScreenContentView(viewModel: viewModel))
    }
    
    private func subscribeToEffects() {
        viewModel.$effect
            .sink { [weak self] effect in
                switch effect {
                case .noEffect:
                    break
                case .showSuccess(message: let message):
                    self?.showSuccessMessage(message)
                case .showError(message: let message):
                    self?.showErrorMessage(message)
                }
            }
            .store(in: &cancellables)
    }
}
