//
//  ConsentCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit

class ConsentCell: UITableViewCell {
    
    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.cornerRadius = 10
            containerView.layer.borderColor = UIColor(rgb: 0xBDBDBD).cgColor
            containerView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var procedure : UILabel!
    @IBOutlet weak var formType : UILabel!
    @IBOutlet weak var statusView : UIView!
    @IBOutlet weak var status : UILabel!
    @IBOutlet weak var day : UILabel!
    @IBOutlet weak var month : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.none;
    }

}
