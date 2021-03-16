//
//  ProcedureVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit
import TTGSnackbar
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
            searchTextFiels.delegate = self
        }
    }
    @IBOutlet weak var tableView : UITableView!{
        didSet{
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 600
        }
    }

    var treatmentID: Int?
    var procedureList: [ProcedureDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProcedure()
        self.title = "Procedures"
        // Do any additional setup after loading the view.
    }
}

extension ProcedureVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return procedureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProcedureCell", for: indexPath) as! ProcedureCell
        cell.procedureName.text = procedureList[indexPath.row].procedureCode
        cell.amountLabel.text = "Rs \(procedureList[indexPath.row].procedureFee!)"
        cell.aboutProcedure.text = procedureList[indexPath.row].authDescription
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DentalProcedureView.showPopup(parentVC: self)
    }
}

extension ProcedureVC : DentalProcedureViewDelegate {
    func didTapOnSave() {
        SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have successfully added a dental procedure.",buttonText: "OK")
    }
}

extension ProcedureVC : SorryViewDelegate {
    func didTapOnOK() {
        
    }
}

//MARK: UITextFieldDelegate
extension ProcedureVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFiels.resignFirstResponder()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        let searchText  = textField.text! + string

        if searchText.count > 0 {
            tableView.isHidden = false

            procedureList = TreatmentManager.sharedInstance.ProcedureList.filter({ (result) -> Bool in
                return result.procedureCode.range(of: searchText, options: .caseInsensitive) != nil
            })
        }
        else{
            procedureList = TreatmentManager.sharedInstance.ProcedureList
        }
        tableView.reloadData()

        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(textField.text?.count == 0){
            procedureList = TreatmentManager.sharedInstance.ProcedureList
            tableView.reloadData()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        procedureList = TreatmentManager.sharedInstance.ProcedureList
            tableView.reloadData()
    }
    
}
//MARK: APICall
extension ProcedureVC {
    
    func getProcedure(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        TreatmentManager.sharedInstance.ProcedureList(treatmentID: treatmentID!, completionHandler: {
                        (success,data,error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alert.dismiss(animated: true, completion: nil)
                }
            if(success){
                self.procedureList = data
                self.tableView.reloadData()
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
}
