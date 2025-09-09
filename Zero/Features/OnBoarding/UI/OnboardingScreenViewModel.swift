//
//  OnboardingScreenViewModel.swift
//  Zero
//
//  Created by Aser Eid on 02/09/2025.
//

import Foundation
import Combine

typealias OnboardingScreenPageState = PageState<String>

final class OnboardingScreenViewModel: ObservableObject {
    //MARK: - Inputs
    private let router: OnboardingScreenRouter
    
    //MARK: - Publishers
    @Published private(set) var effect: OnboardingScreenEffect = .noEffect
    @Published private(set) var state: OnboardingScreenPageState = .initial
    
    init(router: OnboardingScreenRouter) {
        self.router = router
    }
    
    func onApear() {
        self.state = .dataLoaded(data: "Zero App")
    }
    
    func navigateToRoleSelection() {
        router.navigationToChooseRole()
    }
}
