//
//  StaffMemberCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class StaffMemberCell: UITableViewCell {

    @IBOutlet weak var imgContainerView : UIView!
    @IBOutlet weak var memberTypeView : UIView!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var patientNo : UILabel!
    @IBOutlet weak var subTitle : UILabel!
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
