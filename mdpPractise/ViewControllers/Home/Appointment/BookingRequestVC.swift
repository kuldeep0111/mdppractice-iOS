//
//  BookingRequestVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit

class BookingRequestVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}


extension BookingRequestVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "BookingRequestCell", for: indexPath) as! BookingRequestCell
        //cell.img.image = UIImage.init(named: "")
        cell.patientName.text = "Patient: Test Deepak"
        cell.treatedBy.text = "Treating Doctor: Dr. Manjunath"
        cell.appointmentTime.text = "Appointment time: 07:50 PM"
        cell.containerView.layer.borderWidth = 2
        cell.containerView.layer.borderColor = UIColor(rgb: 0xE8E8E8).cgColor
        cell.phoneBtn.setImage(UIImage.init(named: "tikGreen"), for: .normal)
        cell.menuButton.setImage(UIImage.init(named: "crossRed"), for: .normal)
        return cell
    }
}
