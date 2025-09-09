//
//  HostingControllerSetup.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import SwiftUI

extension UIViewController {
    func setupHosting<Content: View>(rootView: Content) {
        // Embed the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: rootView)
        
     //   hostingController.view.backgroundColor = .clear
        // Add the hostingController as a child of your ViewController
        addChild(hostingController)
        
        // Add the SwiftUI view to your ViewController's view hierarchy
        view.addSubview(hostingController.view)
        
        // Set up constraints or frame for the hostingController's view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Notify the hostingController that it has been moved to the current view controller
        hostingController.didMove(toParent: self)
    }
}
