//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//

import SwiftUI

struct ___VARIABLE_productName:identifier___ContentView: View {
    
    @ObservedObject var viewModel: ___VARIABLE_productName:identifier___ViewModel
    
    var body: some View {
        ZStack {
            mainView
        }
        .toolbar(.hidden, for: .navigationBar)
        .withRightToLeftSupport()
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch viewModel.state {
        case .initial:
            EmptyView()
        case .loading:
            ProgressView()
        case .retryView:
            RetryView(action: viewModel.retryActionTapped)
        case .dataLoaded(let data):
            EmptyView()
        }
    }
    
}

// MARK: Data Loaded
extension ___VARIABLE_productName:identifier___ContentView {
    // put your views here
}

#Preview {
    ___VARIABLE_productName:identifier___ContentView(
        viewModel: ___VARIABLE_productName:identifier___ViewModel(
            router: ___VARIABLE_productName:identifier___Router(viewController: nil)
        )
    )
}
