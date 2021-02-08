//
//  NewAppointmentVC.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit
import TTGSnackbar

class NewAppointmentVC: UIViewController {
    
    @IBOutlet weak var appointmentDate : MDPTextField!
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
            reasonOfAppointment.text = "Max 50 words"
            reasonOfAppointment.textColor = UIColor.lightGray
            reasonOfAppointment.delegate = self
        }
    }
    
    @IBOutlet weak var createBtn : UIButton!{
        didSet{
            createBtn.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var addPatientview : UIView!{
        didSet{
            addPatientview.layer.cornerRadius = 8
            addPatientview.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            addPatientview.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            addPatientview.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var reasonOfAppointmentError : UILabel!
    
    var clinicPickerView = UIPickerView()
    var doctorPickerView = UIPickerView()
    var timingPickerView = UIPickerView()
    
    var datePicker = UIDatePicker()
    var pickerToolbar: UIToolbar?
    var selectedTimeSlot = ""
    var clinicNameList = ["Clinic","Clinic","Clinic"]
    var drNameList = ["Dr 1","DR 2","DR 3"]
    var timingList = ["10.00 - 10.30","10.30 - 11.00","11.00 - 11.30"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        self.title = "New Appointment"
        createUIToolBar()
        datePicker.datePickerMode = .date
        appointmentDate?.inputAccessoryView = pickerToolbar
        appointmentDate?.inputView = datePicker
        
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
            textView.text = "Max 50 words"
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: Actions
extension NewAppointmentVC {
    
    @IBAction func didTapOnCreate(_ sender: UIButton){
        if(validateAppointmentDate() && validatePatientID() && validateClinic() && validateDr() && validateTiming()){
            print("Validate")
        }else{
            
        }
    }
    
    @IBAction func didTapOnAddPatientButton(_ sender: UIButton){
        
    }
}

//MARK: Validate
extension NewAppointmentVC {
    
    func validateAppointmentDate() -> Bool{
        if(appointmentDate.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter appointment Date", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validatePatientID() -> Bool{
        if(patientID.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter patient id", duration: .short)
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

//MARK: UIDatePicker
extension NewAppointmentVC {
    func createUIToolBar() {
        
        pickerToolbar = UIToolbar()
        pickerToolbar?.autoresizingMask = .flexibleHeight
        
        //customize the toolbar
        pickerToolbar?.barStyle = .default
        pickerToolbar?.barTintColor = UIColor.white
        pickerToolbar?.backgroundColor = UIColor.black
        pickerToolbar?.isTranslucent = false
        
        //add buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:
                                            #selector(cancelBtnClicked(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
                                            #selector(doneBtnClicked(_:)))
        doneButton.tintColor = UIColor.white
        
        //add the items to the toolbar
        pickerToolbar?.items = [cancelButton, flexSpace, doneButton]
        
    }
    
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
        appointmentDate?.resignFirstResponder()
    }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        appointmentDate?.resignFirstResponder()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        appointmentDate?.text = formatter.string(from: datePicker.date)
    }
}


//MARK: UIPickerView
extension NewAppointmentVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch pickerView {
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
