//
//  UIButton + Extension.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import Foundation
import UIKit

extension UIButton {
    
    func seIconButton(){
        self.layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
}
