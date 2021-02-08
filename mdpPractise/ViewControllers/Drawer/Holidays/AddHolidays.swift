//
//  AddHolidays.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class AddHolidays: UIViewController {

    @IBOutlet weak var startDateTFD : MDPTextField!
    @IBOutlet weak var endDateTFD : MDPTextField!
    @IBOutlet weak var saveBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.layer.cornerRadius = 25
    }
    
    @IBAction func didTapOnSave(_ sender: UIButton){
        
    }
}
