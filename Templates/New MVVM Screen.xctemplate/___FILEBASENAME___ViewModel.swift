//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//

import Foundation
import Combine

typealias ___VARIABLE_productName:identifier___State = PageState<AnyHashable>

class ___VARIABLE_productName:identifier___ViewModel: ObservableObject {
    private let router: ___VARIABLE_productName:identifier___Router
    
    @Published
    private(set) var state: ___VARIABLE_productName:identifier___State = .initial
    
    @Published
    private(set) var effect: ___VARIABLE_productName:identifier___Effect = .noEffect
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        router: ___VARIABLE_productName:identifier___Router
    ) {
        self.router = router
    }
    
    func onAppear() {
        // initialization logic
    }
    
    func retryActionTapped() {
        // add retry logic after failure
    }
}

//MARK: public functions
extension ___VARIABLE_productName:identifier___ViewModel {
    
}

//MARK: private functions
extension ___VARIABLE_productName:identifier___ViewModel {
    
}
