//
//  PatientIDCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 10/02/21.
//

import UIKit

class PatientIDCell: UITableViewCell {

    @IBOutlet weak var patientID : UILabel!
    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.borderColor = UIColor(rgb: 0xBDBDBD).cgColor
            containerView.layer.borderWidth = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = UITableViewCell.SelectionStyle.none;
    }

}
