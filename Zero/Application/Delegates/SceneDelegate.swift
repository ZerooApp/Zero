//
//  SceneDelegate.swift
//  Zero
//
//  Created by Test on 09/09/2025.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupConnection(from: connectionOptions)
        self.setRoot()
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        self.setup(userActivity: userActivity)
    }
}

extension SceneDelegate {
    private func setRoot(_ isAppSafeToLaunch: Bool = true) {
        let splashVC = SplashScreenRouter.create()
        
        self.window?.rootViewController = splashVC
        self.window?.makeKeyAndVisible()
    }
    
    private func setupConnection(from options: UIScene.ConnectionOptions) {
        options.userActivities.forEach {
            self.setup(userActivity: $0)
        }
    }
    
    private func setup(userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let _ = userActivity.webpageURL
        else { return }
    }
}

