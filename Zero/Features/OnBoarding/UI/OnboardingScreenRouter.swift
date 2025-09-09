//
//  OnboardingScreenRouter.swift
//  Zero
//
//  Created by Aser Eid on 02/09/2025.
//

import UIKit

final class OnboardingScreenRouter {
    weak var viewController: OnboardingScreenVC?
    
    init(viewController: OnboardingScreenVC?) {
        self.viewController = viewController
    }
    
    static func create() -> OnboardingScreenVC {
        let vc = OnboardingScreenVC()
        let router = OnboardingScreenRouter(viewController: vc)
        let viewModel = OnboardingScreenViewModel(router: router)
        vc.viewModel = viewModel
        return vc
    }
}

extension OnboardingScreenRouter {
    func navigationToChooseRole() {
        let vc = SplashScreenRouter.create()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
