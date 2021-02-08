//
//  UIView + Extension.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 02/02/21.
//

import Foundation
import UIKit

class MDPView: UIView {

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        self.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        self.layer.borderWidth = 1
    }
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
