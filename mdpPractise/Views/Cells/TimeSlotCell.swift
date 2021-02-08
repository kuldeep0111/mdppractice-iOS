//
//  TimeSlotCell.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit

class TimeSlotCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView : UIView!{
        didSet{
            cellView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var timeSlotLbl : UILabel!
    
}
