//
//  NewConsentFormView.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit
import TTGSnackbar

protocol NewConsentFormViewDelegate {
    func didTapOnSave()
}

class NewConsentFormView: UIViewController {
    
    @IBOutlet weak var patientName : MDPTextField!
    @IBOutlet weak var procedure : MDPTextField!
    @IBOutlet weak var formType : MDPTextField!
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var cancelButton : UIButton!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var alignVertical : NSLayoutConstraint!
    @IBOutlet weak var topSpace : NSLayoutConstraint!
    
    var delegate : NewConsentFormViewDelegate?
    
    var formTypeTitle = ""

}

//MARK: LifeCycle
extension NewConsentFormView{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formType.text = formTypeTitle
        cancelButton.layer.cornerRadius = 25
        saveButton.layer.cornerRadius = 25
        containerView.layer.cornerRadius = 10
        patientName.delegate = self
        procedure.delegate = self
        formType.delegate = self
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnCancel(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
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
extension NewConsentFormView {
    
    @objc func keyboardWillAppear() {
        self.alignVertical.priority = .defaultLow
        self.topSpace.priority = .defaultHigh
    }

    @objc func keyboardWillDisappear() {
        self.topSpace.priority = .defaultLow
        self.alignVertical.priority = .defaultHigh
    }
}

//MARK: UITextFieldDelegate
extension NewConsentFormView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case patientName:
            patientName.resignFirstResponder()
        case procedure:
            procedure.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

//MARK: ValidateForm
extension NewConsentFormView {
    
    func validatePatientName() -> Bool{
        if(patientName.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter patient name", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateProcedure() -> Bool{
        if(procedure.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter procedure", duration: .short)
            snackbar.show()
            return false
        }
    }
}

extension NewConsentFormView {
    
    @IBAction func didTapOnCancel(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnSave(_ sender: UIButton){
        
        if(validatePatientName() && validateProcedure()){
            self.dismiss(animated: true, completion: nil)
            self.delegate?.didTapOnSave()
        }
    }
    
    static func showPopup(parentVC: UIViewController, titleText : String){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "NewConsentFormView") as?
            NewConsentFormView {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parentVC as? NewConsentFormViewDelegate
            popupViewController.formTypeTitle = titleText
            parentVC.present(popupViewController, animated: true)
        }
    }
}
