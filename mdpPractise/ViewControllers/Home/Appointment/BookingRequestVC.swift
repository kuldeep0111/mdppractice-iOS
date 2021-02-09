//
//  BookingRequestVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit

class BookingRequestVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var selectedIndex : Int?
    
    var listData = ["","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
}


extension BookingRequestVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
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
        cell.phoneBtn.tag = indexPath.row
        cell.menuButton.tag = indexPath.row
        cell.phoneBtn.addTarget(self, action: #selector(didTapOnAccept(_:)), for: .touchUpInside)
        cell.menuButton.addTarget(self, action: #selector(didTapOnReject(_:)), for: .touchUpInside)
        return cell
    }
}

//MARK: Actions

extension BookingRequestVC {
    
    @objc func didTapOnAccept(_ sender: UIButton){
        selectedIndex = sender.tag
        AppointmentAcceptRejectView.showPopup(parentVC: self, isReject: false)
    }
    
    @objc func didTapOnReject(_ sender: UIButton){
        selectedIndex = sender.tag
        AppointmentAcceptRejectView.showPopup(parentVC: self, isReject: true)
    }
}

//MARK: AppointmentAcceptRejectViewDelegate
extension BookingRequestVC : AppointmentAcceptRejectViewDelegate {
    func didTapOnConfirm(isReject: Bool) {
        listData.remove(at: selectedIndex!)
        if(isReject){
             
        }else{
            
        }
        tableView.reloadData()
    }
}
