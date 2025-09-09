//
//  SplashScreenContentView.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import SwiftUI

struct SplashScreenContentView: View {
    @ObservedObject var viewModel: SplashScreenViewModel
    
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
extension SplashScreenContentView {
    // put your views here
    private func contentView(appName: String) -> some View {
        VStack {
            Spacer()

            Text(appName)
                .appFont(name: .caption, size: .xxxLarge)
                .foregroundStyle(Colors.titlePrimary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .screenBackground()
    }
}
        
#Preview {
    SplashScreenContentView(
        viewModel:
            SplashScreenViewModel(
                router: SplashScreenRouter(viewController: nil)
            )
    )
}
