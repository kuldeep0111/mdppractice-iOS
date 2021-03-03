//
//  AddNewDrugView.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/03/21.
//

import UIKit
import TTGSnackbar

protocol AddNewDrugViewDelegate {
    func addDrug(drugName : String)
}

class AddNewDrugView: UIViewController {

    var delegate : AddNewDrugViewDelegate?
    
    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var drugName : MDPTextField!
    @IBOutlet weak var strength : MDPTextField!
    @IBOutlet weak var measure : MDPTextField!
    @IBOutlet weak var verticalCenter : NSLayoutConstraint!
    @IBOutlet weak var topAlign : NSLayoutConstraint!
    @IBOutlet weak var addButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}

//MARK: Keyboard Events
extension AddNewDrugView {
    
    @objc func keyboardWillAppear() {
        verticalCenter.priority = .defaultLow
        topAlign.priority = .defaultHigh
    }

    @objc func keyboardWillDisappear() {
        verticalCenter.priority = .defaultHigh
        topAlign.priority = .defaultLow

    }
}

extension AddNewDrugView {
    
    func validateDrugName() -> Bool{
        if(drugName.text!.count > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter drug name", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateStrength() -> Bool{
        if(strength.text!.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter strength", duration: .short)
            snackbar.show()
            return false
        }
    }

    func validateMeasure() -> Bool{
        if(measure.text!.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter measure", duration: .short)
            snackbar.show()
            return false
        }
    }

}


//MARK: Actions
extension AddNewDrugView {
    
    @objc func dismissMe(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnAddButton(_ sender: UIButton){
        if(validateDrugName() && validateStrength() &&  validateMeasure()){
            self.dismiss(animated: true, completion: nil)
            self.delegate?.addDrug(drugName: drugName.text!)
        }
    }
    
    static func showPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "AddNewDrugView") as?
            AddNewDrugView {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parentVC as? AddNewDrugViewDelegate
            parentVC.present(popupViewController, animated: true)
        }
    }
}

