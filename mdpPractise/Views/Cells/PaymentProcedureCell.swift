//
//  PaymentProcedureCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit

class PaymentProcedureCell: UITableViewCell {

    
    @IBOutlet weak var procedureTitle: UILabel!
    @IBOutlet weak var amount  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
