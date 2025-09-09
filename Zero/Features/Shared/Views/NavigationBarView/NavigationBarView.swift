//
//  NavigationBarView.swift
//  Zero
//
//  Created by Test on 09/09/2025.
//

import SwiftUI

struct NavigationBarView: View {
    var middleTitle: LocalizedStringKey?
    
    var body: some View {
        ZStack {
            if let middleTitle = middleTitle {
                Text(middleTitle)
                    .appFont(name: .title, size: .xLarge)
                    .foregroundStyle(Colors.titlePrimary)
            }
            
            HStack {
                Image(.Arrows.arrowLeft)
                    .fitSize(Dimensions.d24)
                Spacer()
            }
        }
        .padding(.horizontal, Spaces.s16)
    }
}

#Preview {
    NavigationBarView(middleTitle: "Notifications")
}
