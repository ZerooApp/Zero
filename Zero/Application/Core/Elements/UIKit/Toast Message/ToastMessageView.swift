//
//  ToastMessageView.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit
import SwiftMessages

final class ToastMessageView: BaseView {
    // MARK: - Outlets
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!

    // MARK: - Variables
    private var state: State = .error

    // MARK: - Base Functions
    class func instanceFromNib() -> ToastMessageView {
        UINib(nibName: "ToastMessageView", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! ToastMessageView
    }

    override func awakeFromNib() {
        setupView()
    }

    // MARK: - Config Functions
    func configure(message: String, state: State) {
        titleLabel.text = message
        titleLabel.textColor = UIColor(resource: state.textColor)
        iconImage.image = UIImage(resource: state.icon)
        containerView.backgroundColor = UIColor(resource: state.backgroundColor)
        self.state = state
    }
    
    // MARK: - Core Functions
    func display() {
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.duration = .seconds(seconds: TimeInterval(floatLiteral: 5))
        config.presentationStyle = .top
        config.dimMode = .gray(interactive: true)
        self.configureDropShadow()
        SwiftMessages.show(config: config, view: self)
    }

    // MARK: - Actions
    @IBAction private func closeButtonTapped() {
        SwiftMessages.hideAll()
    }
    
    // MARK: - Private Helpers
    private func setupView() {
        containerView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 28)
        titleLabel.font = .appFont(name: .body, size: .medium)
        closeButton.setTitle("", for: .normal)
    }
}
