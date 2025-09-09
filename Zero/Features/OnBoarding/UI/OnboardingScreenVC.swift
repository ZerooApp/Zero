//
//  OnboardingScreenVC.swift
//  Zero
//
//  Created by Aser Eid on 02/09/2025.
//

import UIKit
import Combine

final class OnboardingScreenVC: UIViewController {
    var viewModel: OnboardingScreenViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHosting(rootView: OnboardingContentView(viewModel: viewModel))
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
