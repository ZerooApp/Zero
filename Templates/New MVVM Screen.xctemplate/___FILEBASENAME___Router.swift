//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//

import UIKit

class ___VARIABLE_productName: identifier___Router {
    weak var viewController: ___VARIABLE_productName: identifier___VC?
    
    init(viewController: ___VARIABLE_productName: identifier___VC?) {
        self.viewController = viewController
    }
    
    static func create() -> ___VARIABLE_productName: identifier___VC {
        let vc = ___VARIABLE_productName: identifier___VC()
        let router = ___VARIABLE_productName: identifier___Router(viewController: vc)
        let viewModel = ___VARIABLE_productName: identifier___ViewModel(
            router: router
        )
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: Navigation
    
}
