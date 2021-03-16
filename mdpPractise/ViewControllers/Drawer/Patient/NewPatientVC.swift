//
//  NewPatientVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 16/03/21.
//

import UIKit
import TTGSnackbar

protocol NewPatientVCDelegate {
    func updatePatientList()
}

class NewPatientVC: UIViewController {
    
    var delegate : NewPatientVCDelegate?
    @IBOutlet weak var nameTextField : MDPTextField!
    @IBOutlet weak var GenderTextField : MDPTextField!
    @IBOutlet weak var DOBTextField : MDPTextField!
    @IBOutlet weak var mobileTextField : MDPTextField!
    @IBOutlet weak var emailTextField : MDPTextField!
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    @IBOutlet weak var createBtn : UIButton!{
        didSet{
            createBtn.layer.cornerRadius = 25
        }
    }
    
    var genderPicker =  UIPickerView()
    var datePicker = UIDatePicker()
    var pickerToolbar: UIToolbar?
    var genderList = ["Male","Female","Other"]
    
    var patientModel: PatientListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = patientModel == nil ? "Add Patient" : ""
        if(patientModel != nil){
            self.nameTextField.isUserInteractionEnabled = false
            self.GenderTextField.isUserInteractionEnabled = false
            self.DOBTextField.isUserInteractionEnabled = false
            self.emailTextField.isUserInteractionEnabled = false
            self.mobileTextField.isUserInteractionEnabled = false
            self.createBtn.isHidden = true
            getPatientDetail()
        }
        createUIToolBar()
        genderPicker = UIPickerView()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.backgroundColor = .white
        GenderTextField.inputAccessoryView = pickerToolbar
        GenderTextField.inputView = genderPicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        DOBTextField?.inputAccessoryView = pickerToolbar
        DOBTextField?.inputView = datePicker
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
extension NewPatientVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }
    
    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}

//MARK: Validation
extension NewPatientVC {
    
    func validateName() -> Bool{
        if(nameTextField.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter name", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validatePhone() -> Bool{
        
        if(mobileTextField.text?.count == 10){
            return true
            
        }else{
            let snackbar = TTGSnackbar(message: "Please enter valid number", duration: .short)
            snackbar.show()
        }
        return false
    }
    
    func validateGender() -> Bool{
        if(GenderTextField.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter gender", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateDate() -> Bool{
        if(DOBTextField.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter date", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateEmail() -> Bool{
        if(emailTextField.text?.isEmail() == true){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter valid email", duration: .short)
            snackbar.show()
            return false
        }
    }
}

//MARK: Action's
extension NewPatientVC {
    
    @IBAction func didTapOnCreatePatient(_ sender: UIButton){
        if(validateName() && validateGender() && validateEmail() && validatePhone() && validateDate()){
            AddNewPatient()
        }
    }
    
}

//MARK: UIPickerView
extension NewPatientVC : UIPickerViewDelegate , UIPickerViewDataSource {
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
        GenderTextField.text = genderList[row]
    }
}

//MARK: API CALL
extension NewPatientVC {
    
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
        GenderTextField?.resignFirstResponder()
        DOBTextField.resignFirstResponder()
    }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        
        if(GenderTextField.isFirstResponder){
            GenderTextField?.resignFirstResponder()
            if(GenderTextField.text?.count == 0){
                GenderTextField.text = genderList[0]
            }
        }else if(DOBTextField.isFirstResponder){
            DOBTextField?.resignFirstResponder()
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
            DOBTextField?.text = "\(day)/\(month)/\(datePicker.date.year)"
        }
    }
}

extension NewPatientVC: SorryViewDelegate {
    func didTapOnOK() {
        navigationController?.popViewController(animated: true)
        self.delegate?.updatePatientList()
    }
}

//MARK: API CALL
extension NewPatientVC {
    
    func getPatientDetail(){

        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)
        
        PatientManager.sharedInstance.PatientDetail(patientID: (patientModel?.patientID!)!, memberID: (patientModel?.memberID!)!, completionHandler: {(success,data,error) in
            self.dismiss(animated: false, completion: nil)
            if(success){
                self.nameTextField.text = data!.profile?.name
                self.GenderTextField.text = data!.profile?.gender
                self.DOBTextField.text = data!.profile?.dob
                self.emailTextField.text = data!.contacts?.email
                self.mobileTextField.text = data!.contacts?.phoneNo
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
    
    func AddNewPatient(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)
        
        PatientManager.sharedInstance.NewPatient(name: nameTextField.text!, DOB: DOBTextField.text!, gender: GenderTextField.text!, email: emailTextField.text!, phoneNo: mobileTextField.text!, completionHandler: {(success,data,error) in
            self.dismiss(animated: false, completion: nil)
            if(success){
                SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have successfully added a new patient.", buttonText: "OK")
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
}
