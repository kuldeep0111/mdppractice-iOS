//
//  StaffMemberVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class StaffMemberVC: UIViewController {

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
        cell.imgContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.imgContainerView.layer.shadowOpacity = 1
        cell.imgContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.imgContainerView.layer.shadowRadius = 10
        cell.imgContainerView.layer.masksToBounds = true
        cell.img.image = UIImage.init(named: "female")
        cell.name.text = "Amir khan"
        cell.patientNo.text = "P1678SH"
        cell.subTitle.text = "Walk-in-Patient"
        cell.memberTypeView.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }

}
