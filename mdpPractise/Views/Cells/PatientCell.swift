//
//  PatientCell.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit

class PatientCell: UITableViewCell {

    @IBOutlet weak var imgContainerView : UIView!{
        didSet{
            imgContainerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            imgContainerView.layer.shadowOpacity = 1
            imgContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            imgContainerView.layer.shadowRadius = 10
            imgContainerView.layer.cornerRadius = 5
            //imgContainerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var patientNo : UILabel!
    @IBOutlet weak var subTitle : UILabel!
    @IBOutlet weak var phoneBtn : UIButton!
    @IBOutlet weak var menuBtn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.none;
        // Configure the view for the selected state
    }
}
