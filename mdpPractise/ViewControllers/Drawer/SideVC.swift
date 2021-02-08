//
//  SideVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit
import SJSwiftSideMenuController

class SideVC: UIViewController {
    
    @IBOutlet weak var imgContainerView : UIView!{
        didSet{
            imgContainerView.layer.cornerRadius = 37.5
        }
    }
    @IBOutlet weak var arrowIcon : UIImageView!{
        didSet{
            arrowIcon.tintColor = UIColor.white
        }
    }
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var id : UILabel!
    @IBOutlet weak var tableView : UITableView!
    
    var ItemList : [(img: String, title : String)] = [
        ("home1","Profile"),
        ("home1","Photos"),
        ("home1","Consent Form"),
        ("home1","Staff Member"),
        ("home1","Clinic"),
        ("home1","Holiday"),
        ("male1","MDP Members"),
        ("male1","Walk-in-Patients"),
        //("male1","Patient Plan"),
        ("home1","Treaments"),
        ("payment","Payments"),
        ("home1","Tutorials"),
        ("feedback","Feedback"),
        ("home1","About Us"),
        ("logout","Sign Out"),
        ("logout","Sign Out")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SJSwiftSideMenuController.enableDimbackground = true
    }
    
}

extension SideVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(ItemList.count - 1 == indexPath.row){
            let cell = tableView.dequeueReusableCell(withIdentifier: "VersionCell", for: indexPath) as! VersionCell
            cell.version.text = "App Ver: 1.0.0"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerCell", for: indexPath) as! DrawerCell
        cell.img.image = UIImage.init(named: ItemList[indexPath.row].img)
        cell.cellTitle.text = ItemList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SJSwiftSideMenuController.hideLeftMenu()
        switch indexPath.row {
        case 1:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
            SJSwiftSideMenuController.pushViewController(vc, animated: true)
        case 2:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "ConsentVC") as! ConsentVC
            SJSwiftSideMenuController.pushViewController(vc, animated: true)
        case 3:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "StaffMemberVC") as! StaffMemberVC
            SJSwiftSideMenuController.pushViewController(vc, animated: true)
        case 4:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "ClinicVC") as! ClinicVC
            SJSwiftSideMenuController.pushViewController(vc, animated: true)
        case 5:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "HolidayVC") as! HolidayVC
            SJSwiftSideMenuController.pushViewController(vc, animated: true)
            
        case 6:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PatientListVC") as! PatientListVC
            vc.isMDPMember = true
            SJSwiftSideMenuController.pushViewController(vc, animated: true)
        case 7:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PatientListVC") as! PatientListVC
            SJSwiftSideMenuController.pushViewController(vc, animated: true)
        case 9:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PaymentDetailVC") as! PaymentDetailVC
            SJSwiftSideMenuController.pushViewController(vc, animated: true)

        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
}
