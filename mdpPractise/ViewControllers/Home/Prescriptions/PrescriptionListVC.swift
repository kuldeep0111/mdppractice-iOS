//
//  PrescriptionListVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/03/21.
//

import UIKit

class PrescriptionListVC: UIViewController {

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
//        cell.menuButton.addTarget(self, action: #selector(didTapOnAccept(_:)), for: .touchUpInside)
        return cell
    }
}
