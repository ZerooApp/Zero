//
//  OnboardingContentView.swift
//  Zero
//
//  Created by Aser Eid on 02/09/2025.
//

import SwiftUI

struct OnboardingContentView: View {
    @ObservedObject var viewModel: OnboardingScreenViewModel
    
    var body: some View {
        ZStack {
            mainView
            if viewModel.state == .loading {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                    .disabled(true)
                ProgressView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .withRightToLeftSupport()
        .onAppear {
            viewModel.onApear()
        }
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch viewModel.state {
        case .initial:
            EmptyView()
        case .loading:
            contentView(appName: "")
        case .retryView:
            RetryView()
        case .dataLoaded(let data):
            contentView(appName: data)
        }
    }
    
}

// MARK: Data Loaded
extension OnboardingContentView {
    // put your views here
    private func contentView(appName: String) -> some View {
        VStack(alignment: .center, spacing: Spaces.s12) {
            headerView
            imageView
            Spacer()
            button
        }
        .padding(.horizontal, Spaces.s16)
        .screenBackground()
    }
}

extension OnboardingContentView {
    private var headerView: some View {
        VStack(alignment: .center, spacing: Spaces.s8) {
            Text("Welcome")
                .appFont(name: .title, size: .xxLarge)
                .foregroundStyle(Colors.titlePrimary)
            
            Text("Easy booking, organized schedules, better experience")
                .appFont(name: .body, size: .xLarge)
                .foregroundStyle(Colors.titlePrimary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, Spaces.s16)
    }
    
    private var imageView: some View {
        Image(.Onboarding.onboarding1X)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: 460)
    }
    
    private var button: some View {
        Button(
            "Get Started",
            action: { viewModel.navigateToRoleSelection() }
        )
        .buttonStyle(
            .primaryFill()
        )
        .frame(height: Dimensions.d48)
        .padding(.bottom, Spaces.s32)
    }
    
}

#Preview {
    OnboardingContentView(
        viewModel:
            OnboardingScreenViewModel(
                router: OnboardingScreenRouter(viewController: nil)
            )
    )
}
