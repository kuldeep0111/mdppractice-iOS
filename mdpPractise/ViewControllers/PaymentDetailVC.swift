//
//  PaymentDetailVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit

class PaymentDetailVC: UIViewController {

    @IBOutlet weak var patientName : UILabel!
    @IBOutlet weak var dateName : UILabel!
    @IBOutlet weak var clinicName : UILabel!
    
    @IBOutlet weak var subTotal : UILabel!
    @IBOutlet weak var insurancePay : UILabel!
    @IBOutlet weak var discount : UILabel!
    @IBOutlet weak var balance : UILabel!

    @IBOutlet weak var sendReminderBtn : UIButton!{
        didSet{
            sendReminderBtn.layer.cornerRadius = 24
        }
    }
    @IBOutlet weak var markPaidBtn : UIButton!{
    didSet{
        markPaidBtn.layer.cornerRadius = 24
    }
}
    @IBOutlet weak var paidByPatient : UILabel!

    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var tableViewHeight : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Payment Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewHeight.constant = 4 * 36
        view.layoutSubviews()
    }
}


extension PaymentDetailVC {
    
    @IBAction func didTapOnSendReminder(_ sender: UIButton){
        
    }
    
    @IBAction func didTapOnMarkPaid(_ sender: UIButton){
        
    }
}


extension PaymentDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentProcedureCell", for: indexPath) as! PaymentProcedureCell
        cell.procedureTitle.text = "Collection of microrganisms"
        cell.amount.text = "Rs 1000"
        return cell
    }
    
    
    
    
}
