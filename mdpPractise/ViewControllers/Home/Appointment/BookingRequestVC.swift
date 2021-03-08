//
//  BookingRequestVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit
import TTGSnackbar

class BookingRequestVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var selectedIndex : Int?
    
    var listData = ["","","","","","",""]
    
    var BookingList : [AppointmentListModel] = AppointmentManager.sharedInstance.BlockAppointmentList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
}


extension BookingRequestVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "BookingRequestCell", for: indexPath) as! BookingRequestCell
        //cell.img.image = UIImage.init(named: "")
        cell.patientName.text = "Patient: \(BookingList[indexPath.row].patientname)"
        cell.treatedBy.text = "Treating Doctor: Dr. \(BookingList[indexPath.row].docname)"
        cell.appointmentTime.text = "Appointment time: \(BookingList[indexPath.row].appointmentTime)"
        cell.containerView.layer.borderWidth = 2
        cell.containerView.layer.borderColor = UIColor(rgb: 0xE8E8E8).cgColor
        cell.phoneBtn.tag = indexPath.row
        cell.menuButton.tag = indexPath.row
        cell.phoneBtn.addTarget(self, action: #selector(didTapOnReject(_:)), for: .touchUpInside)
        cell.menuButton.addTarget(self, action: #selector(didTapOnAccept(_:)), for: .touchUpInside)
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
        if(isReject){
            RejectAppointment(appointmentID: BookingList[selectedIndex!].appointmentID)
        }else{
            AcceptAppointment(appointmentID: BookingList[selectedIndex!].appointmentID)
        }
        tableView.reloadData()
    }
}

//MARK: API CALL
extension BookingRequestVC {
    
    func AcceptAppointment(appointmentID: String){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        AppointmentManager.sharedInstance.AcceptAppointment(appointmentID: appointmentID, completionHandler: {(success,data,error) in
            self.dismiss(animated: true, completion: nil)
            if(success){
                self.AppointmentList()
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
    
    func RejectAppointment(appointmentID: String){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        AppointmentManager.sharedInstance.RejectAppointment(appointmentID: appointmentID, completionHandler: {(success,data,error) in
            self.dismiss(animated: true, completion: nil)
            if(success){
                self.AppointmentList()
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }

    
    func AppointmentList(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)

        AppointmentManager.sharedInstance.AppointmentList(completionHandler: { (success,list,error) in
            self.dismiss(animated: true, completion: nil)
            if(success){
                self.BookingList = list!
                self.tableView.reloadData()
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
}
