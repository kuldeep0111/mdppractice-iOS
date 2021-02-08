//
//  TextField.swift
//  mdppractice
//
//  Created by rahul on 28/01/21.
//

import Foundation
import UIKit

class MDPTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        self.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        self.layer.borderWidth = 1
        self.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.font = UIFont.init(name: "Inter-Regular", size: 16)
    }
    
    let padding = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITextField {
    
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 10, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 20, y: 0, width: 30, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
    
    func setRightIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 10, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 30, y: 20, width: 40, height: 30))
        iconContainerView.backgroundColor = UIColor.clear
       iconContainerView.addSubview(iconView)
       rightView = iconContainerView
       rightViewMode = .always
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        paddingView.backgroundColor = UIColor.clear
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    
}
