//
//  NewAppointmentVC.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit
import TTGSnackbar

class NewAppointmentVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField : MDPTextField!
    @IBOutlet weak var GenderTextField : MDPTextField!
    @IBOutlet weak var ageTextField : MDPTextField!
    @IBOutlet weak var patientID : MDPTextField!
    @IBOutlet weak var clinicName : MDPTextField!
    @IBOutlet weak var doctorName : MDPTextField!
    @IBOutlet weak var timing : MDPTextField!
    @IBOutlet weak var reasonOfAppointment : UITextView!{
        didSet{
            reasonOfAppointment.layer.cornerRadius = 8
            reasonOfAppointment.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            reasonOfAppointment.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            reasonOfAppointment.layer.borderWidth = 1
            reasonOfAppointment.textColor = UIColor.lightGray
            reasonOfAppointment.delegate = self
        }
    }
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    
    @IBOutlet weak var createBtn : UIButton!{
        didSet{
            createBtn.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var reasonOfAppointmentError : UILabel!
    
    var clinicPickerView = UIPickerView()
    var doctorPickerView = UIPickerView()
    var timingPickerView = UIPickerView()
    var genderPicker =  UIPickerView()
    
    var datePicker = UIDatePicker()
    var pickerToolbar: UIToolbar?
    var selectedTimeSlot = ""
    var clinicNameList = ["Clinic","Clinic","Clinic"]
    var drNameList = ["Dr 1","DR 2","DR 3"]
    var timingList = ["10.00 - 10.30","10.30 - 11.00","11.00 - 11.30"]
    
    var genderList = ["Male","Female","Other"]
}

//MARK: LifeCycle
extension NewAppointmentVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        self.title = "New Appointment"
        clinicPickerView = UIPickerView()
        clinicPickerView.dataSource = self
        clinicPickerView.delegate = self
        clinicPickerView.backgroundColor = UIColor.white
        
        doctorPickerView = UIPickerView()
        doctorPickerView.dataSource = self
        doctorPickerView.delegate = self
        doctorPickerView.backgroundColor = UIColor.white
        
        timingPickerView = UIPickerView()
        timingPickerView.dataSource = self
        timingPickerView.delegate = self
        timingPickerView.backgroundColor = UIColor.white
        
        clinicName.inputAccessoryView = pickerToolbar
        clinicName.inputView = clinicPickerView
        
        doctorName.inputAccessoryView = pickerToolbar
        doctorName.inputView = doctorPickerView
        timing.text = selectedTimeSlot
        timing.inputAccessoryView = pickerToolbar
        timing.inputView = timingPickerView
        self.navigationController?.navigationBar.isHidden = false
        
        genderPicker = UIPickerView()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.backgroundColor = .white
        
        GenderTextField.inputAccessoryView = pickerToolbar
        GenderTextField.inputView = genderPicker
       // GenderTextField.delegate = self
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
extension NewAppointmentVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}



extension NewAppointmentVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
        }
    }
}

extension NewAppointmentVC : SorryViewDelegate {
    func didTapOnOK() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: Actions
extension NewAppointmentVC {
    
    @IBAction func didTapOnCreate(_ sender: UIButton){
        if(validatePatientID() && validateName() && validateGender() && validateAge() && validateClinic() && validateDr() && validateTiming()){
            SorryView.showPopup(parentVC: self, subText: "Appointment")
        }
    }
    
    @IBAction func didTapOnAddPatientButton(_ sender: UIButton){
        
    }
    
    @IBAction func didTapOnAddPatientIDButton(_ sender: UIButton){
        PatientIDView.showPopup(parentVC: self)
    }

}

extension NewAppointmentVC : PatientIDViewDelegate {
    func pickPatientID(id: String) {
        patientID.textColor = UIColor(rgb: 0x0173b7)
        patientID.text = id
    }
}

//MARK: Validate
extension NewAppointmentVC {
        
    func validatePatientID() -> Bool{
        if(patientID.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter patient id", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateName() -> Bool{
        if(nameTextField.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter name", duration: .short)
            snackbar.show()
            return false
        }
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
    
    func validateAge() -> Bool{
        if(ageTextField.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter age", duration: .short)
            snackbar.show()
            return false
        }
    }


    
    
    func validateClinic() -> Bool{
        if(clinicName.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter clinic name", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateDr() -> Bool{
        if(doctorName.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter doctor name", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateTiming() -> Bool{
        if(timing.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter time", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    
    
}

//MARK: UIPickerView
extension NewAppointmentVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch pickerView {
        case genderPicker:
            return genderList.count
        case clinicPickerView:
            return clinicNameList.count
        case doctorPickerView:
            return drNameList.count
        case timingPickerView:
            return timingList.count
            
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case genderPicker:
            return genderList[row]
        case clinicPickerView:
            return clinicNameList[row]
        case doctorPickerView:
            return drNameList[row]
        case timingPickerView:
            return timingList[row]
            
        default:
            break
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch pickerView {
        case genderPicker:
            GenderTextField.text = genderList[row]
        case clinicPickerView:
            clinicName.text = clinicNameList[row]
        case doctorPickerView:
            doctorName.text = drNameList[row]
        case timingPickerView:
            timing.text = timingList[row]
        default:
            break
        }
        self.view.endEditing(true)
    }
}
