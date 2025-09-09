//
//  SplashScreenRouter.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit

final class SplashScreenRouter {
    weak var viewController: SplashScreenVC?
    
    init(viewController: SplashScreenVC?) {
        self.viewController = viewController
    }
    
    static func create() -> SplashScreenVC {
        let vc = SplashScreenVC()
        let router = SplashScreenRouter(viewController: vc)
        let viewModel = SplashScreenViewModel(router: router)
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: Navigation
    
    func navigateToMain() {
        guard let mainCoordinator = MainCoordinator.instance else {
            print("Failed to create MainCoordinator")
            return
        }
        mainCoordinator.start()
    }
    
    func navigateToOnBoarding() {
        let vc = OnboardingScreenRouter.create()
        viewController?.pushVC(vc)
    }
}
