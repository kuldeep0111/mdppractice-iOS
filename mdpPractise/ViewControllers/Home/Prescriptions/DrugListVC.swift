//
//  DrugListVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/03/21.
//

import UIKit
import DropDown

protocol DrugListVCDelegate {
    func passDrugs(drugName: String)
}


class DrugListVC: UIViewController {

    let dropDown = DropDown()
    var delegate : DrugListVCDelegate?
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Prescriptions"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addNewDrugs))
    }
}

extension DrugListVC {
    @objc func addNewDrugs(){
        AddNewDrugView.showPopup(parentVC: self)
    }
}

extension DrugListVC : AddNewDrugViewDelegate {
    func addDrug(drugName: String) {
        SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have succesfully added drug", buttonText: "OK")
    }
}

extension DrugListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "DrugCell", for: indexPath) as! DrugCell
        cell.drugName.text = "Crocin kidk"
        cell.strength.text = "100 mg"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        delegate?.passDrugs(drugName: "Crocin kidk")
    }
}

