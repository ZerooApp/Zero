//
//  SplashScreenViewModel.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import Foundation
import Combine

typealias SplashScreenPageState = PageState<String>

final class SplashScreenViewModel: ObservableObject {
    //MARK: - Inputs
    private let router: SplashScreenRouter
    
    //MARK: - Publishers
    @Published private(set) var effect: SplashScreenEffect = .noEffect
    @Published private(set) var state: SplashScreenPageState = .initial
    
    //MARK: - Life Cycle
    init(router: SplashScreenRouter) {
        self.router = router
    }
    
    func onApear() {
        self.state = .dataLoaded(data: "Zero")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.router.navigateToMain()
        }
    }
}

// MARK: - Public Functions
extension SplashScreenViewModel {
    func navigateToHome() {
        router.navigateToMain()
    }
}

// MARK: - Private Functions
extension SplashScreenViewModel {
    
}
