//
//  ProcedureCell.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit

class ProcedureCell: UITableViewCell {

    @IBOutlet weak var procedureName : UILabel!
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var aboutProcedure : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.none;
    }
}
