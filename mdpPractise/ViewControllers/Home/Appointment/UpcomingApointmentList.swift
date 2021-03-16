//
//  UpcomingApointmentList.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit
import DropDown
class UpcomingApointmentList: UIViewController {
    
    var dropDown = DropDown()
    @IBOutlet weak var tableView : UITableView!{
        didSet{
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 600
        }
    }
    
    var UpcomiongList : [AppointmentListModel] = AppointmentManager.sharedInstance.UpcomingAppointmentList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Done")
        if(tableView != nil){
            UpcomiongList = AppointmentManager.sharedInstance.UpcomingAppointmentList
            self.tableView.reloadData()
        }
    }
}

extension UpcomingApointmentList : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UpcomiongList.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 106
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        //cell.img.image = UIImage.init(named: "")
        cell.patientName.text = "Patient: \(UpcomiongList[indexPath.row].patientname)"
        cell.treatedBy.text = "Treating Doctor: Dr. \(UpcomiongList[indexPath.row].docname)"
        cell.appointmentTime.text = "Appointment time: \(UpcomiongList[indexPath.row].appointmentTime)"
        cell.containerView.layer.borderWidth = 2
        cell.containerView.layer.borderColor = UIColor(rgb: 0xE8E8E8).cgColor
        cell.phoneBtn.addTarget(self, action: #selector(didTapOnCall), for: .touchUpInside)
        cell.menuButton.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
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
    
        
    @objc func didTapOnMenuButton(_ sender: UIButton){
        
        dropDown.dataSource = ["Check In", "Reschedule","Cancel Appt","Patient Log"]//4
        dropDown.backgroundColor = .white
        dropDown.textColor = UIColor(rgb: 0x666666)
        dropDown.separatorColor = UIColor(rgb: 0x666666)
        dropDown.width = 150
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
//            switch index {
//            case 0:
//                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "StaffMemberVC") as! StaffMemberVC
//                self?.navigationController!.pushViewController(vc, animated: true)
//                break
//            case 1:
//                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
//                self?.navigationController?.pushViewController(vc, animated: true)
//               break
//
//            default:
//                break
//            }
            
        }
        
    }
}
