//
//  TreatmentsVC.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit
import DropDown
class PatientListVC: UIViewController {

     var dropDown = DropDown()
    
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
        self.navigationController?.navigationBar.isHidden = false
        if(isMDPMember == false){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnAdd))
        }
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
        cell.phoneBtn.addTarget(self, action: #selector(didTapOnCall), for: .touchUpInside)
        cell.menuBtn.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


//MARK: Actions
extension PatientListVC {
    
    @objc func didTapOnCall(){
        
        if let url = URL(string: "tel://9886868688"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }    }
    
        
        @objc func didTapOnMenuButton(_ sender: UIButton){
            
            dropDown.dataSource = ["Treatment", "Medical History","Patient Log","Dental Images"]//4
            dropDown.backgroundColor = .white
            dropDown.textColor = UIColor(rgb: 0x666666)
            dropDown.separatorColor = UIColor(rgb: 0x666666)
            dropDown.width = 150
            dropDown.anchorView = sender //5
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
                guard let _ = self else { return }
                switch index {
                case 3:
                    let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
                    self?.navigationController?.pushViewController(vc, animated: true)
                   break
    
                default:
                    break
                }
                
            }
            
        }
    }
