//
//  TreatmentDetailCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit

class TreatmentDetailCell: UITableViewCell {

    @IBOutlet weak var statusView : UIView!
    @IBOutlet weak var cointainerView : UIView!
    @IBOutlet weak var procedureCode : UILabel!
    @IBOutlet weak var treatmentFee : UILabel!
    @IBOutlet weak var insurancePay : UILabel!
    @IBOutlet weak var patientPay : UILabel!
    @IBOutlet weak var descriptionText : UILabel!
    @IBOutlet weak var toothNumber : UILabel!
    @IBOutlet weak var quadrant : UILabel!
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
