//
//  AppointmentVC.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit
import DropDown
import TTGSnackbar
class AppointmentDetailsVC: UIViewController {
    
    //@IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var tableView : UITableView!{
        didSet{
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 600
        }
    }
    @IBOutlet weak var collectionViewHeight : NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight : NSLayoutConstraint!
    @IBOutlet weak var appointmerntDate : UILabel!
    
    var dropDown = DropDown()
    var date : Date?
    
    var appointmentList : [AppointmentByDayModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppointment()
        setMainCollectionViewLayout()
        navigationController?.navigationBar.isHidden = false
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        var tableviewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //getAppointment()
        appointmerntDate.text = "Appointment for :\(date!.day)/\(date!.month)/\(date!.year)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func setMainCollectionViewLayout(){
        let layout1 = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        let cellwidth = (width - 60)/3
        layout1.itemSize = CGSize(width: cellwidth, height: 50)
        layout1.scrollDirection = .vertical
        layout1.minimumLineSpacing = 10
        layout1.minimumInteritemSpacing = 5
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.setCollectionViewLayout(layout1, animated: true)
        
    }
}

extension AppointmentDetailsVC {
    @objc func addNewAppointmet(){
        let story : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "NewAppointmentVC") as! NewAppointmentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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

extension AppointmentDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TimingSlot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSlotCell", for: indexPath) as! TimeSlotCell
        cell.timeSlotLbl.text = TimingSlot[indexPath.row]
        cell.cellView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TimeSlotCell {
            cell.cellView.backgroundColor = UIColor(rgb: 0x0173B7)
            cell.timeSlotLbl.textColor = UIColor.white
        }
        let vc = mdpStoryBoard.instantiateViewController(identifier: "NewAppointmentVC") as! NewAppointmentVC
        vc.selectedTimeSlot = TimingSlot[indexPath.row]
        vc.selectedDate = "\(date!.day)/\(date!.month)/\(date!.year)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TimeSlotCell else {
            return
        }
        cell.cellView.backgroundColor = UIColor(rgb: 0xf6f6f6)
        cell.timeSlotLbl.textColor = UIColor(rgb: 0x333333)
    }
}

extension AppointmentDetailsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        //cell.img.image = UIImage.init(named: "")
        cell.patientName.text = "Patient: \(appointmentList[indexPath.row].patientName)"
        cell.treatedBy.text = "Treating Doctor: \(appointmentList[indexPath.row].docName)"
        cell.appointmentTime.text = "Appointment time: \(appointmentList[indexPath.row].appointmentTime)"
        cell.containerView.layer.borderWidth = 2
        cell.containerView.layer.borderColor = UIColor(rgb: 0xE8E8E8).cgColor
        cell.menuButton.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = mdpStoryBoard.instantiateViewController(identifier: "NewAppointmentVC") as NewAppointmentVC
        vc.appointmentDetail = appointmentList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: API CALL
extension AppointmentDetailsVC {
    
    func getAppointment(){

        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)
        
        AppointmentManager.sharedInstance.AppointmentByDay(day: date?.day, month: date?.month, year: date?.year, clinicID: selectedClinic?.clinicID, completionHandler: {
                        (success,data,error) in
                alert.dismiss(animated: false, completion: nil)
            if(success){
                self.appointmentList = data!
                self.tableViewHeight.constant = CGFloat((self.appointmentList.count * 111) + 50 )
                self.collectionView.reloadData()
                self.tableView.reloadData()
                self.view.layoutIfNeeded()
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
}
