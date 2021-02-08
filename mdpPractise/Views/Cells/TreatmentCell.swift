//
//  TreatmentCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit

class TreatmentCell: UITableViewCell {

    @IBOutlet weak var treatmentNo : UILabel!
    @IBOutlet weak var doctorName : UILabel!
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var menuBtn : UIButton!
    @IBOutlet weak var phoneBtn : UIButton!
    @IBOutlet weak var statusView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = UITableViewCell.SelectionStyle.none;
    }

}

extension TreatmentCell {
    
    @IBAction func didTapOnMenuBtn(_ sender : UIButton){
        
    }
    
    @IBAction func didTapOnPhoneBtn(_ sender : UIButton){
        
    }

    
}
