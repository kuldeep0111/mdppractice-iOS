//
//  SignUpVC.swift
//  mdppractice
//
//  Created by rahul on 28/01/21.
//

import UIKit
import TTGSnackbar

class SignUpVC: UIViewController {

    @IBOutlet weak var nameTextfield : MDPTextField!
    @IBOutlet weak var emailTextfield : MDPTextField!
    @IBOutlet weak var DOBTextfield : MDPTextField!
    @IBOutlet weak var GenderTextfield : MDPTextField!
    @IBOutlet weak var checkBtn : UIButton!
    @IBOutlet weak var submitBtn : UIButton!
    @IBOutlet weak var containerView : UIView!
    
    @IBOutlet weak var nameError : UILabel!
    @IBOutlet weak var dobError : UILabel!
    @IBOutlet weak var emailError : UILabel!
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    
    
    var genderList = ["Male","Female","Other"]
    var gradePicker: UIPickerView!
    var datePicker = UIDatePicker()
    
    var pickerToolbar: UIToolbar?
    
    var mobileNo = ""
    
}

//MARK: LifeCycle
extension SignUpVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
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
extension SignUpVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}

//MARK: Helping Method
extension SignUpVC {
    func setupUI(){
        submitBtn.layer.cornerRadius = 25
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
        containerView.layer.shadowColor = UIColor(red: 0.004, green: 0.451, blue: 0.718, alpha: 0.1).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 10
        
        gradePicker = UIPickerView()
        gradePicker.dataSource = self
        gradePicker.delegate = self
        GenderTextfield.inputView = gradePicker
        GenderTextfield.text = genderList[0]
        createUIToolBar()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        DOBTextfield?.inputAccessoryView = pickerToolbar
        DOBTextfield?.inputView = datePicker

        nameTextfield.delegate = self
        emailTextfield.delegate = self
        DOBTextfield.delegate = self
        GenderTextfield.delegate = self
        
    }
}

//MARK: Action's
extension SignUpVC {
    @IBAction func didTapOnCheck(_ sender: UIButton){
        if(checkBtn.isSelected){
            checkBtn.isSelected = false
        }else{
            checkBtn.isSelected = true
        }
    }
    
    @IBAction func didTapOnSubmit(_ sender: UIButton){
        
        if(validateName() && validateEmail() && validateDate() && validateCheck()){
                submitAPICall()
        }
    }
}

//MARK: UIPickerView
extension SignUpVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return genderList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        GenderTextfield.text = genderList[row]
        self.view.endEditing(true)
    }
}

//MARK: UIDatePicker
extension SignUpVC {
    
    
    func createUIToolBar() {
            
            pickerToolbar = UIToolbar()
            pickerToolbar?.autoresizingMask = .flexibleHeight

            //customize the toolbar
            pickerToolbar?.barStyle = .default
            pickerToolbar?.barTintColor = UIColor.white
            pickerToolbar?.backgroundColor = UIColor.white
            pickerToolbar?.isTranslucent = false

            //add buttons
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:
                #selector(cancelBtnClicked(_:)))
        cancelButton.tintColor = UIColor.black
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
                #selector(doneBtnClicked(_:)))
            doneButton.tintColor = UIColor.black

            //add the items to the toolbar
            pickerToolbar?.items = [cancelButton, flexSpace, doneButton]
            
        }
        
        @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
            DOBTextfield?.resignFirstResponder()
        }
        
        @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            DOBTextfield?.resignFirstResponder()
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            
           var day = "\(datePicker.date.day)"
           var month = "\(datePicker.date.month)"
            if day.count == 1 {
                day = "0\(day)"
            }
            if(month.count == 1){
                month = "0\(month)"
            }
            DOBTextfield?.text = "\(day)/\(month)/\(datePicker.date.year)"
          }
       }

//MARK: Validate TextFields
extension SignUpVC {
    func validateName() -> Bool{
        if(nameTextfield.text?.count ?? 0 > 2){
            nameError.text = ""
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter Username", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateEmail() -> Bool{
        if(emailTextfield.text?.isEmail() == true){
            emailError.text = ""
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter valid email", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateDate() -> Bool{
        if(DOBTextfield.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter DOB", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateCheck() -> Bool{
        if(checkBtn.isSelected){
           return true
        }else{
            let snackbar = TTGSnackbar(message: "Please agree to the terms and conditions", duration: .short)
            snackbar.show()

           return false
        }
    }
    
}

//MARK: TextFieldDelegate
extension SignUpVC : UITextFieldDelegate{
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField
        {
        case nameTextfield:
            emailTextfield.becomeFirstResponder()
            break
        case emailTextfield:
            DOBTextfield.becomeFirstResponder()
            break
        case DOBTextfield:
            GenderTextfield.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: API Call
extension SignUpVC {
    
    func submitAPICall(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)

        
        AuthenticationManager.sharedInstance.signUP(mobileNo, name: nameTextfield.text!, email: emailTextfield.text!, gender: GenderTextfield.text!, dob: DOBTextfield.text!){
            (successful, response, error) in
            self.dismiss(animated: true, completion: nil)
            if(successful){
                UserDefaults.standard.setValue(3, forKey: "userType")
                let story : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "SetupClinicVC") as! SetupClinicVC
                vc.mobileNo = self.mobileNo
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
            }
        }
    }
}
