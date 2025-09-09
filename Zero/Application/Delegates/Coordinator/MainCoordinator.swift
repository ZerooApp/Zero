//
//  MainCoordinator.swift
//  Zero
//
//  Created by Aser Eid on 03/09/2025.
//

import UIKit

class MainCoordinator {
    let window: UIWindow
    private let userPreferences: UserPreferencesProtocol
    
    private init(
        window: UIWindow,
        userPreferences: UserPreferencesProtocol
    ) {
        self.window = window
        self.userPreferences = userPreferences
    }
    
    func start() {
        let appControllers = [
//            HomeRouter.create(),
//            DiscoverRouter.create(),
//            AIChatRouter.create(),
//            ProfileRouter.create()
            OnboardingScreenRouter.create(),
            OnboardingScreenRouter.create(),
            OnboardingScreenRouter.create(),
            OnboardingScreenRouter.create()
        ]
        
        if userPreferences.isFirstLaunch {
            let appTabBarController = AppTabBarController(controllers: appControllers)
            window.rootViewController = appTabBarController
        } else {
//            let onboardingVC = OnboardingScreenRouter.create()
//            let navigationController = UINavigationController(rootViewController: onboardingVC)
//            navigationController.isNavigationBarHidden = true
//            window.rootViewController = navigationController
            let appTabBarController = AppTabBarController(controllers: appControllers)
            window.rootViewController = appTabBarController
        }
        
        window.makeKeyAndVisible()
    }
    
    static var instance: MainCoordinator? {
        guard let window = UIApplication.shared.windows.first else { return nil }
        let userPreferences = UserPreferences.shared
        return MainCoordinator(
            window: window,
            userPreferences: userPreferences
        )
    }
}


