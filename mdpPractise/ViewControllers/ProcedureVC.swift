//
//  ProcedureVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit

class ProcedureVC: UIViewController {

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
        self.title = "Procedures"
        // Do any additional setup after loading the view.
    }
}

extension ProcedureVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProcedureCell", for: indexPath) as! ProcedureCell
        cell.procedureName.text = "G0847"
        cell.amountLabel.text = "Rs 500"
        cell.aboutProcedure.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DentalProcedureView.showPopup(parentVC: self)
    }
}

extension ProcedureVC : DentalProcedureViewDelegate {
    func didTapOnSave() {
        
    }
}
