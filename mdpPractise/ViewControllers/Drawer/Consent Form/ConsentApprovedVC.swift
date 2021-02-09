//
//  ConsentApprovedVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit

class ConsentApprovedVC: UIViewController {

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

    @IBOutlet weak var tableView : UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        // Do any additional setup after loading the view.
    }
    
}

extension ConsentApprovedVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsentCell", for: indexPath) as! ConsentCell
        cell.name.text = "Siddu Singh"
        cell.procedure.text = "Remind Again"
        cell.formType.text = "ABCD"
        cell.day.text = "21"
        cell.status.text = "Approved"
        cell.statusView.layer.cornerRadius = 5
        cell.statusView.backgroundColor = UIColor(rgb: 0x27AE60)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }

}
