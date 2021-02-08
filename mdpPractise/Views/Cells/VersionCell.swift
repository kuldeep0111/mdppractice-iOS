//
//  VersionCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit

class VersionCell: UITableViewCell {

    @IBOutlet weak var version : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = UITableViewCell.SelectionStyle.none;
    }

}
