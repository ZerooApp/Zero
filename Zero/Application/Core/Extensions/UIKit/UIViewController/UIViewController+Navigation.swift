//
//  UIViewController+Navigation.swift
//  Zero
//
//  Created by Test on 07/09/2025.
//

import UIKit.UIViewController

extension UIViewController {
    func pushVC(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}
