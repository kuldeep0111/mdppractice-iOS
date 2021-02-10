//
//  PatientIDView.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 10/02/21.
//

import UIKit


protocol PatientIDViewDelegate {
    func pickPatientID(id : String)
}

class PatientIDView: UIViewController {

    
    var delegate : PatientIDViewDelegate?
    
    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var containerViewHeight : NSLayoutConstraint!
    
    @IBOutlet weak var addButton : UIButton!{
        didSet{
            addButton.layer.cornerRadius = 25
        }
    }
    
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
    @IBOutlet weak var tableView : UITableView!

    var patientIDList = ["A1B2C3D1","A1B2C3D2","A1B2C3D3","A1B2C3D4","A1B2C3D4","A1B2C3D6"]
    var filterList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        filterList = patientIDList
        
        if filterList.count > 4 {
            containerViewHeight.constant = CGFloat(82 + (4 * 57))
        }
        else{
            containerViewHeight.constant = CGFloat(82 + (filterList.count * 57))
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMe))
        self.view.addGestureRecognizer(tapGestureRecognizer)

    }
}

extension PatientIDView  : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText  = searchTextFiels.text!

        if searchText.count > 0 {
            tableView.isHidden = false
            filterList = patientIDList.filter({ (result) -> Bool in
                return result.range(of: searchText, options: .caseInsensitive) != nil
            })
            if(filterList.count == 0) {
                tableView.isHidden = true
            }else{
                tableView.isHidden = false
            }
            
            if filterList.count > 4 {
                containerViewHeight.constant = CGFloat(85 + (4 * 58))
            }
            else{
                containerViewHeight.constant = CGFloat(85 + (filterList.count * 58))
                containerViewHeight.constant = tableView.isHidden ? 150 : containerViewHeight.constant
            }
            
            tableView.reloadData()
        }
        else{
            filterList = patientIDList
        }
        return true
    }
}

extension PatientIDView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientIDCell", for: indexPath) as! PatientIDCell
        cell.patientID.text = filterList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.pickPatientID(id: filterList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
   
}

//MARK: Actions

extension PatientIDView {
    
    @objc func dismissMe(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnAddButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        self.delegate?.pickPatientID(id: searchTextFiels.text!)
    }
    
    static func showPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "PatientIDView") as?
            PatientIDView {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parentVC as? PatientIDViewDelegate
            parentVC.present(popupViewController, animated: true)
        }
    }
}


