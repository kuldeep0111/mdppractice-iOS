//
//  TreatmentsVC.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit

class PatientListVC: UIViewController {

    @IBOutlet weak var searchTextFiels : MDPTextField!{
        didSet{
            searchTextFiels.setLeftPaddingPoints(50)
            searchTextFiels.layer.cornerRadius = 25
            searchTextFiels.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            searchTextFiels.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            searchTextFiels.layer.borderWidth = 1
            searchTextFiels.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            searchTextFiels.font = UIFont.init(name: "Inter-Regular", size: 16)
        }
    }
    @IBOutlet weak var tableView : UITableView!
    
    var isMDPMember = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = isMDPMember ? "MDP Members" : "Walk-in-Patients"
        setupNavigationBar()
    }
}

//MARK: Actions
extension PatientListVC {
    func setupNavigationBar(){
        if(isMDPMember){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "notification")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnNotificaitons))
        }else{
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnAdd))
        }
    }
    
    @objc func didTapOnNotificaitons(){
        let vc = mdpStoryBoard.instantiateViewController(identifier: "NotificaitonVC") as NotificaitonVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapOnAdd(){
        
    }
}

extension PatientListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as! PatientCell
        cell.img.image = UIImage.init(named: "female")
        cell.name.text = "Amir khan"
        cell.patientNo.text = "P1678SH"
        cell.subTitle.text = "Walk-in-Patient"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
