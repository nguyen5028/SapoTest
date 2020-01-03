//
//  UIViewExtension.swift
//  SapoTest
//
//  Created by AgileTech on 1/3/20.
//  Copyright © 2020 NguyenNv. All rights reserved.
//

import UIKit
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
enum DesignableButtonStyle: Int {
    case Regular = 0
    case Light
    case Dark
    case Fancy
    case Alert
}

@IBDesignable class DesignableButton: UIButton {
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var buttonStyleNumber: Int = 0 {
        didSet {
            switch buttonStyleNumber {
            case DesignableButtonStyle.Light.rawValue:
                tintColor = UIColor.white
                backgroundColor = UIColor.lightGray
                break
            case DesignableButtonStyle.Dark.rawValue:
                tintColor = UIColor.white
                backgroundColor = UIColor.darkGray
                break
            case DesignableButtonStyle.Fancy.rawValue:
                tintColor = UIColor.white
                backgroundColor = UIColor.purple
                break
            case DesignableButtonStyle.Alert.rawValue:
                tintColor = UIColor.white
                backgroundColor = UIColor.red
                break
            default:
                // default Regular
                tintColor = UIColor.white
                backgroundColor = UIColor.black
                break
            }
        }
    }
    
    @IBInspectable var roundedCornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = roundedCornerRadius
        }
    }
    
    @IBInspectable var verticalPadding: CGFloat = 0 {
        didSet {
            contentEdgeInsets = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        }
    }
    
    @IBInspectable var horizontalPadding: CGFloat = 0 {
        didSet {
            contentEdgeInsets = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        }
    }
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
    override open var isHighlighted: Bool {
        didSet {
            let colorHighlighted = UIColor(hex: "#2EB273")
            backgroundColor = isHighlighted ? colorHighlighted : UIColor.white
        }
    }
}
