//
//  TreatmentDetailVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit
import DropDown
class TreatmentDetailVC: UIViewController {

    var dropDown = DropDown()
    @IBOutlet weak var treatmentNumber : UILabel!
    @IBOutlet weak var treatmentDate : UILabel!
    @IBOutlet weak var treatingBy : UILabel!
    @IBOutlet weak var clinicName : UILabel!
    @IBOutlet weak var addNewBtn : UIButton!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var treatmentNumView : UIView!{
        didSet{
            treatmentNumView.layer.cornerRadius = 8.0
            treatmentNumView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            treatmentNumView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            treatmentNumView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var treatDateView : UIView!{
        didSet{
            treatDateView.layer.cornerRadius = 8.0
            treatDateView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            treatDateView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            treatDateView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var treatedByView : UIView!{
        didSet{
            treatedByView.layer.cornerRadius = 8.0
            treatedByView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            treatedByView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            treatedByView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var clinicNameView : UIView!{
        didSet{
            clinicNameView.layer.cornerRadius = 8.0
            clinicNameView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            clinicNameView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            clinicNameView.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var tableViewHeight : NSLayoutConstraint!
    
    
    var attrs = [
        NSAttributedString.Key.font : UIFont.init(name: "Inter-Medium", size: 14),
        NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x0173B7),
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

    var attributedString = NSMutableAttributedString(string:"")

    @IBOutlet weak var paymentDetailView : UIView!{
        didSet{
            paymentDetailView.layer.cornerRadius = 10
            paymentDetailView.layer.borderWidth = 1
            paymentDetailView.layer.borderColor = UIColor(rgb: 0xBDBDBD).cgColor
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Treatment Details"
        
        let buttonTitleStr = NSMutableAttributedString(string:"Add New", attributes:attrs)
        attributedString.append(buttonTitleStr)
        addNewBtn.setAttributedTitle(attributedString, for: .normal)

        
        var tableviewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
        tableViewHeight.constant = 10 * 184
        self.view.layoutIfNeeded()
    }
    
    @IBAction func didTapOnAddNewBtn(_ sender: UIButton){
        let vc = mdpStoryBoard.instantiateViewController(identifier: "ProcedureVC") as! ProcedureVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension TreatmentDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreatmentDetailCell", for: indexPath) as! TreatmentDetailCell
        cell.procedureCode.text = "G3094"
        cell.toothNumber.text = "5"
        cell.descriptionText.text = "asdf asdfa asdf  asdf"
        cell.insurancePay.text = "Rs 400"
        cell.quadrant.text = "2"
        cell.patientPay.text = "Rs 200"
        cell.treatmentFee.text = "Rs 500"
        cell.statusView.layer.cornerRadius = 5
        cell.cointainerView.layer.cornerRadius = 10
        cell.cointainerView.layer.borderWidth = 1
        cell.cointainerView.layer.borderColor = UIColor(rgb: 0x0173B7).cgColor
        cell.menuBtn.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 184
    }
}


extension TreatmentDetailVC {
    
    @objc func didTapOnMenuButton(_ sender: UIButton){
        
        dropDown.dataSource = ["Edit", "Complete","Consent Form","Delete"]//4
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
