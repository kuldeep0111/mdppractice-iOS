//
//  DentalProcedureView.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit
import TTGSnackbar

protocol DentalProcedureViewDelegate {
    func didTapOnSave(tooth: String, quadrent: String, remarks: String)
}

class DentalProcedureView: UIViewController {

    var delegate : DentalProcedureViewDelegate?
    
    @IBOutlet weak var toothNo : MDPTextField!
    @IBOutlet weak var quadrant : MDPTextField!
    @IBOutlet weak var reasonOfAppointment : UITextView!{
        didSet{
            reasonOfAppointment.layer.cornerRadius = 8.0
            reasonOfAppointment.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            reasonOfAppointment.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            reasonOfAppointment.layer.borderWidth = 1
            reasonOfAppointment.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            reasonOfAppointment.font = UIFont.init(name: "Inter-Regular", size: 16)
        }
    }
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var checkButton : UIButton!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var alignVertical : NSLayoutConstraint!
    @IBOutlet weak var topSpace : NSLayoutConstraint!


}

//MARK: LifeCycle
extension DentalProcedureView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 25
        containerView.layer.cornerRadius = 10
        toothNo.delegate = self
        quadrant.delegate = self
        reasonOfAppointment.delegate = self
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMe))
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
//MARK: Actions
extension DentalProcedureView {
    
    @objc func dismissMe(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnCheck(_ sender: UIButton){
        
        if(checkButton.isSelected){
            checkButton.isSelected = false
        }else{
            checkButton.isSelected = true
        }
    }

    
    @IBAction func didTapOnSave(_ sender: UIButton){
        
        if(validatePatientName() && validateProcedure()){
            self.dismiss(animated: true, completion: nil)
            self.delegate?.didTapOnSave(tooth: toothNo.text!, quadrent: quadrant.text!, remarks: reasonOfAppointment.text!)
        }
    }
    
    static func showPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "DentalProcedureView") as?
            DentalProcedureView {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parentVC as? DentalProcedureViewDelegate
            parentVC.present(popupViewController, animated: true)
        }
    }
}

//MARK: ValidateForm
extension DentalProcedureView {
    
    func validatePatientName() -> Bool{
        if(toothNo.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter tooth number", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateProcedure() -> Bool{
        if(quadrant.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter quadrant", duration: .short)
            snackbar.show()
            return false
        }
    }
}

//MARK: Keyboard Events
extension DentalProcedureView {
    
    @objc func keyboardWillAppear() {
        self.alignVertical.priority = .defaultLow
        self.topSpace.priority = .defaultHigh
    }

    @objc func keyboardWillDisappear() {
        self.topSpace.priority = .defaultLow
        self.alignVertical.priority = .defaultHigh
    }
}


extension DentalProcedureView : UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case toothNo:
            toothNo.resignFirstResponder()
            break
        case quadrant:
            quadrant.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    func textViewShouldReturn(_ textField: UITextField) -> Bool {
        reasonOfAppointment.resignFirstResponder()
        return true
    }
}
