//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//

import UIKit
import Combine

class ___VARIABLE_productName:identifier___VC: UIViewController {
    
    var viewModel: ___VARIABLE_productName:identifier___ViewModel!
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHosting(rootView: ___VARIABLE_productName:identifier___ContentView(viewModel: viewModel))
        subscribeToEffects()
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
