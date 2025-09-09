//
//  UIView+Extensions.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit

extension UIView {
    func setBorder(borderWidth: CGFloat = 1,
                   color: UIColor = .gray,
                   cornerRadius: CGFloat = 12) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    
    func bindToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.topAnchor),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor)
        ])
    }
    
    func bindToSuperview(with insets: UIEdgeInsets) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    func addShadow(color: UIColor, alpha: CGFloat, xValue: CGFloat, yValue: CGFloat, blur: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(alpha)
        self.layer.shadowOffset = CGSize(width: xValue, height: yValue)
        self.layer.shadowRadius = blur/2
    }
    
    func addElArabyDefaultShadow() {
        self.addShadow(color: .black,
                       alpha: 0.5,
                       xValue: -1,
                       yValue: -1,
                       blur: 20)
    }
    
    func addViewWithAnimation(animationDuration: TimeInterval = 0.3) {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func removeViewWithAnimation(animationDuration: TimeInterval = 0.3) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    // MARK: Slide View - Top To Bottom
    func slideInFromTopToBottom(duration: TimeInterval = 0.65, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            if let completion = completion {
                completion()
            }
        }
        let transition: CATransition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromBottom
        self.layer.add(transition, forKey: kCATransition)
        CATransaction.commit()
    }
    
    func slideOutFromBottomToTop(duration: TimeInterval = 0.5,
                                 completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.frame = CGRect(x: self.frame.origin.x, y: -(self.frame.origin.y + self.frame.height), width: self.frame.width, height: self.frame.height)
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    class func createInstanceFromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
    
    func enable() {
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
    
    func disable() {
        self.alpha = 0.3
        self.isUserInteractionEnabled = false
    }
}

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor: UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation: Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode: Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode: Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
