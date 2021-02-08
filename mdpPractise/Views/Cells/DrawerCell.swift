//
//  DrawerCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit

class DrawerCell: UITableViewCell {

    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var cellTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.none;
    }

}
