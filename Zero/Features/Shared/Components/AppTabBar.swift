//
//  AppTabBar.swift
//  Zero
//
//  Created by Test on 10/09/2025.
//

import UIKit

extension UIApplication {
    class func isRTL() -> Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

enum AppTabs: Int, CaseIterable {
    
    case home
    case discover
    case ai
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "Home".localized
        case .discover:
            return "Explore".localized
        case .ai:
            return "Homes& AI".localized
        case .profile:
            return "Profile".localized
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .home:
            return .Arrows.arrowLeft
        case .discover:
            return .checkmarkCircleFill
        case .ai:
            return .checkmarkCircleFill
        case .profile:
            return .checkmarkCircleFill
        }
    }
}
final class AppTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private let controllers: [UIViewController]
    private var dotView: UIView?
    private let splashImageView = UIImageView(image: .checkmarkCircleFill)
    
    init(controllers: [UIViewController], defaultSelectedIndex: Int = 0) {
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
        selectedIndex = defaultSelectedIndex
        self.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        self.controllers = []
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
        setupTabBarStyle()
        configureTabBarItemsPosition()
    }
    
    override var selectedIndex: Int {
        didSet {
            if let selectedItem = tabBar.items?[selectedIndex] {
                addDotIndicator(to: selectedItem)
                addSplash(to: selectedItem)
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedItem = selectedViewController?.tabBarItem {
            addDotIndicator(to: selectedItem)
            addSplash(to: selectedItem)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tabBar.frame.height != 100  && !isScreenSmall() {
            setSizeOfTabbar()
            applyOvalMaskToTabBar()
        }
        if isScreenSmall() {
            tabBar.roundCorners(corners: [
                .layerMinXMinYCorner, .layerMaxXMinYCorner
            ], radius: 60)
        }
        tabBar.setNeedsLayout()
        tabBar.layoutIfNeeded()
    }
    
    private func applyOvalMaskToTabBar() {
        
        let tabBarHeight: CGFloat =  100
        let ovalHeight: CGFloat = 30
        let ovalPath = UIBezierPath()
        
        // Start at the left edge of the tab bar
        ovalPath.move(to: CGPoint(x: 0, y: ovalHeight))
        
        ovalPath.addCurve(
            to: CGPoint(x: tabBar.bounds.width, y: ovalHeight),
            controlPoint1: CGPoint(x: 0, y: 0),
            controlPoint2: CGPoint(x: tabBar.bounds.width, y: 0))
        
        // Draw the straight line down to the bottom of the tab bar
        ovalPath.addLine(to: CGPoint(x: tabBar.bounds.width, y: tabBarHeight))
        ovalPath.addLine(to: CGPoint(x: 0, y: tabBarHeight))
        
        // Close the path
        ovalPath.close()
        
        // Create a shape layer and set its path to the custom shape
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ovalPath.cgPath
        
        // Apply the shape layer as the tab bar's mask
        tabBar.layer.mask = shapeLayer
    }
    
    private func isScreenSmall() -> Bool {
        return UIScreen.main.bounds.height <= 667
    }
    
    private func setSizeOfTabbar() {
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame            = tabBar.frame
            tabFrame.size.height    = 100
            tabFrame.origin.y       = view.frame.size.height - 100
            tabBar.frame            = tabFrame

        }
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.viewControllers?.forEach {
            let isSelectedVC = $0 == viewController
            if isSelectedVC {
                addDotIndicator(to: $0.tabBarItem)
                addSplash(to: $0.tabBarItem)
            }
        }
    }
    
    private func configureTabBarItems() {
        guard self.controllers.count == AppTabs.allCases.count else {
            fatalError("Please use `init(controllers: [UIViewController])` initializer and pass five tabs!")
        }
        let navControllers = self.controllers.map {
            UINavigationController(rootViewController: $0)
        }
        navControllers.enumerated().forEach {
            let tabCase = AppTabs(rawValue: $0)!
            $1.tabBarItem = UITabBarItem(
                title: tabCase.title.localized,
                image: .init(resource: tabCase.icon),
                selectedImage: .init(resource: tabCase.icon)
            )
        }
        self.viewControllers = navControllers
    }
    
    private func setupTabBarStyle() {
        // Create UITabBarItemAppearance for normal and selected states
        let itemApp = UITabBarItemAppearance()
        
        // Unselected item appearance: red text and 50% image opacity
        itemApp.normal.titleTextAttributes = [
            .font: UIFont.appFont(name: .caption, size: .small),
            .foregroundColor: UIColor.black.withAlphaComponent(0.5)
        ]
        itemApp.normal.iconColor = .black.withAlphaComponent(0.5)
        
        // Selected item appearance: black text and full image opacity
        itemApp.selected.titleTextAttributes = [
            .font: UIFont.appFont(name: .title, size: .small),
            .foregroundColor: UIColor.red
        ]
        itemApp.selected.iconColor = .red
        
        // Customize UIBarAppearance
        let barApp = UIBarAppearance()
        barApp.backgroundEffect = nil
        barApp.backgroundColor = .clear
        barApp.shadowColor = nil
        
        // Create UITabBarAppearance and assign item appearance
        let appear = UITabBarAppearance(barAppearance: barApp)
        appear.shadowColor = nil
        appear.backgroundColor = .clear
        appear.stackedItemPositioning = .centered
        appear.stackedLayoutAppearance = itemApp
        appear.inlineLayoutAppearance = itemApp
        appear.compactInlineLayoutAppearance = itemApp
        appear.stackedItemSpacing = UIScreen.main.bounds.width / 6
        
        // Assign to tab bar
        tabBar.standardAppearance = appear
        
        // For iOS 15 and above, use scrollEdgeAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appear
        }
        
        // Additional tab bar customization
        tabBar.backgroundColor = .white

    }
    
    private func configureTabBarItemsPosition() {
        let itemApp = UITabBarItemAppearance()
        let verticalOffset: CGFloat = -20.0
        
        if  isScreenSmall() {
            itemApp.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalOffset)
            itemApp.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalOffset)
            tabBar.items?.forEach { item in
                item.imageInsets = UIEdgeInsets(top: -2, left: 0, bottom: 2 , right: 0)
            }
        }
        else {
            tabBar.items?.forEach { item in
                item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8 , right: 0)
            }
        }
    }
    
    private func addDotIndicator(to tabBarItem: UITabBarItem) {
//        guard UIApplication.hasBottomNotch() else {
//            return
//        }
        self.dotView?.removeFromSuperview()
        
        let dotSize: CGFloat = isScreenSmall() ? 4 : 6
        
        let itemIndex = tabBar.items?.firstIndex(of: tabBarItem) ?? 0
        let itemView = tabBar.subviews[itemIndex + 1]
        let itemViewFrame = itemView.frame
        let dotView = UIView(frame: CGRect(
            x: itemViewFrame.origin.x + (itemViewFrame.size.width / 2) - (dotSize / 2),
            y: itemViewFrame.maxY + 4,
            width: dotSize,
            height: dotSize
        ))
        dotView.backgroundColor = .orange
        
        // Set a corner radius to make it a circle
        dotView.layer.cornerRadius = dotSize / 2
        dotView.clipsToBounds = true
        tabBar.addSubview(dotView)
        self.dotView = dotView
    }
    
    private func addSplash(to tabBarItem: UITabBarItem) {
                guard let tabBar = tabBarItem.value(forKey: "view") as? UIView else {
                    return
                }
        let yValue: CGFloat = isScreenSmall() ? tabBar.bounds.height/2 - 4 : tabBar.bounds.height*2/3
        splashImageView.frame = CGRect(x: -4,
                                       y: yValue,
                                     width: tabBar.bounds.width,
                                       height:  tabBar.bounds.height)
        
        tabBar.addSubview(splashImageView)
    }
}

