//
//  NotificationCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var cellTitle : UILabel!
    @IBOutlet weak var subTitle : UILabel!
    
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
