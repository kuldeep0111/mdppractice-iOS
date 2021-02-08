//
//  AppointmentCell.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit

class AppointmentCell: UITableViewCell {

    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor(red: 232, green: 232, blue: 232, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var horizontolView : UIView!
    @IBOutlet weak var patientName : UILabel!
    @IBOutlet weak var treatedBy : UILabel!
    @IBOutlet weak var appointmentTime : UILabel!
    @IBOutlet weak var phoneBtn : UIButton!
    @IBOutlet weak var menuButton : UIButton!
    
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
