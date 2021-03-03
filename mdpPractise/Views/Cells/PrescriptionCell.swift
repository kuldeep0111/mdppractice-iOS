//
//  PrescriptionCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/03/21.
//

import UIKit

class PrescriptionCell: UITableViewCell {

    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.borderColor = UIColor(rgb: 0xE8E8E8).cgColor
            containerView.layer.borderWidth = 1
            containerView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var drugName : UILabel!
    @IBOutlet weak var strength : UILabel!
    @IBOutlet weak var duration : UILabel!
    @IBOutlet weak var instructions : UILabel!
    @IBOutlet weak var menuButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.none;
    }

}
