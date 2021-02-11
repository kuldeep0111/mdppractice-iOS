//
//  SideVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit
import SideMenu

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
        ("profile_icon","Profile"),
        ("pics","Photos"),
        ("consent","Consent Form"),
        ("staff","Staff Member"),
        ("holiday","Holidays"),
        ("staff","MDP Members"),
        //("male1","Walk-in-Patients"),
        ("male1","Patient Plan"),
        ("payment","Payments"),
        ("tutorial","Tutorials"),
        ("feedback","Feedback"),
        ("about","About Us"),
        ("phonecall","Support"),
        ("SignOut","Sign Out"),
        ("logout","Sign Out")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.navigationBar.isHidden = false
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
        
        switch indexPath.row {
        case 1:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
            self.navigationController!.pushViewController(vc, animated: true)
        case 2:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "ConsentVC") as! ConsentVC
            self.navigationController!.pushViewController(vc, animated: true)
        case 3:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "StaffMemberVC") as! StaffMemberVC
            self.navigationController!.pushViewController(vc, animated: true)
        case 4:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "HolidayVC") as! HolidayVC
            self.navigationController!.pushViewController(vc, animated: true)

        case 5:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PatientListVC") as! PatientListVC
            vc.isMDPMember = true
            self.navigationController!.pushViewController(vc, animated: true)
            
        case 6:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PatientPlanVC") as! PatientPlanVC
            self.navigationController!.pushViewController(vc, animated: true)

            
        case 7:
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PaymentDetailVC") as! PaymentDetailVC
            self.navigationController!.pushViewController(vc, animated: true)

        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
}
