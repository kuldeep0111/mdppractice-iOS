//
//  PrescriptionListVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/03/21.
//

import UIKit
import DropDown
class PrescriptionListVC: UIViewController {

    let dropDown = DropDown()
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Prescriptions List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addNewPrescriptions))
    }
}


extension PrescriptionListVC {
    
    @objc func addNewPrescriptions(){
        let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "AddNewPrescriptionsVC") as! AddNewPrescriptionsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PrescriptionListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PrescriptionCell", for: indexPath) as! PrescriptionCell
        //cell.img.image = UIImage.init(named: "")
        cell.drugName.text = "Crocin kidk"
        cell.strength.text = "100 mg"
        cell.duration.text = "1 DAY"
        cell.containerView.layer.borderWidth = 2
        cell.containerView.layer.borderColor = UIColor(rgb: 0xE8E8E8).cgColor
        cell.instructions.text = "After food"
        cell.menuButton.tag = indexPath.row
        cell.menuButton.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        return cell
    }
}


extension PrescriptionListVC {
    
    @objc func didTapOnMenuButton(_ sender: UIButton){
        dropDown.dataSource = ["Share", "Edit", "Print", "Delete"]//4
        dropDown.backgroundColor = .white
        dropDown.textColor = UIColor(rgb: 0x666666)
        dropDown.separatorColor = UIColor(rgb: 0x666666)
        dropDown.width = 150
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            //sender.setTitle(item, for: .normal) //9
            
            switch index {
            case 0:
//                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "TreatmentDetailVC") as! TreatmentDetailVC
//                self?.navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
//                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
//                self?.navigationController?.pushViewController(vc, animated: true)
               break
             
            case 2:
//                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PrescriptionListVC") as! PrescriptionListVC
//                self?.navigationController?.pushViewController(vc, animated: true)
               break

            case 3:
//                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PaymentDetailVC") as! PaymentDetailVC
//                self?.navigationController?.pushViewController(vc, animated: true)
               break

            default:
                break
            }
        }
    }
}
