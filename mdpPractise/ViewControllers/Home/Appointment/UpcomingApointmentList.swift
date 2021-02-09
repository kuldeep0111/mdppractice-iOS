//
//  UpcomingApointmentList.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit

class UpcomingApointmentList: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

extension UpcomingApointmentList : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        //cell.img.image = UIImage.init(named: "")
        cell.patientName.text = "Patient: Test Deepak"
        cell.treatedBy.text = "Treating Doctor: Dr. Manjunath"
        cell.appointmentTime.text = "Appointment time: 07:50 PM"
        cell.containerView.layer.borderWidth = 2
        cell.containerView.layer.borderColor = UIColor(rgb: 0xE8E8E8).cgColor
        cell.phoneBtn.addTarget(self, action: #selector(didTapOnCall), for: .touchUpInside)
        return cell
    }
}

//MARK: Action's

extension UpcomingApointmentList {
    
    @objc func didTapOnCall(){
        
        if let url = URL(string: "tel://9886868688"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }    }
    
}
