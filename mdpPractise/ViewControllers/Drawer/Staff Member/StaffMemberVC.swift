//
//  StaffMemberVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit
import DropDown
class StaffMemberVC: UIViewController {

    var dropDown = DropDown()
    
    @IBOutlet weak var searchTextFiels : UITextField!{
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
    
    @IBOutlet weak var tableView : UITableView!{
        didSet{
            self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 16, right: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Staff Member"
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addNewStaffMember))
    }
}

//MARK: Actions
extension StaffMemberVC {
    @objc func addNewStaffMember(){
        let vc = mdpStoryBoard.instantiateViewController(identifier: "AddStaffMemberVC") as AddStaffMemberVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UITableViewDelegate
extension StaffMemberVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaffMemberCell", for: indexPath) as! StaffMemberCell
        cell.img.image = UIImage.init(named: "female")
        cell.name.text = "Amir khan"
        cell.patientNo.text = "P1678SH"
        cell.subTitle.text = "Assistant"
        cell.memberTypeView.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

}


//MARK: HelpingMethod
extension StaffMemberVC {
    
    @objc func didTapOnMenuButton(_ sender: UIButton){
        
        dropDown.dataSource = ["Details", "Delete"]//4
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
