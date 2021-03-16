//
//  NewAppointmentVC.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit
import TTGSnackbar

protocol NewAppointmentVCDelegate {
    func loadData()
}

class NewAppointmentVC: UIViewController, UITextFieldDelegate {
    
    var delegate: NewAppointmentVCDelegate?
    
    @IBOutlet weak var nameTextField : MDPTextField!
    @IBOutlet weak var GenderTextField : MDPTextField!
    @IBOutlet weak var ageTextField : MDPTextField!
    @IBOutlet weak var patientID : MDPTextField!
    @IBOutlet weak var clinicName : MDPTextField!{
        didSet{
            clinicName.text = selectedClinic?.clinicName
        }
    }
    
    @IBOutlet weak var dateTextField : MDPTextField!
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
    var selectedDate = ""
    var clinicNameList : [ClinicListModel] = ClinicManager.sharedInstance.clinicArray
    
    var genderList = ["Male","Female","Other"]
    var drNameList : [DoctorModel] = []
    var selectedDoctor : Int?
    var appointmentDetail : AppointmentByDayModel?
}

//MARK: LifeCycle
extension NewAppointmentVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        getDoctorList()
        createUIToolBar()
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
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        dateTextField?.inputAccessoryView = pickerToolbar
        dateTextField?.inputView = datePicker
        dateTextField.text = selectedDate
        
       // GenderTextField.delegate = self
        setupData()
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

extension NewAppointmentVC {
    
   func setupData(){
    if appointmentDetail != nil {
        patientID.text = "\(String(describing: appointmentDetail!.patientID!))"
        nameTextField.text = appointmentDetail?.patientName
       // GenderTextField.text = appointmentDetail
       // ageTextField.text = appointmentDetail.ag
        clinicName.text = appointmentDetail!.clinicName
        doctorName.text = appointmentDetail!.docName
        dateTextField.text = "\(appointmentDetail!.appointmentDate!.day)/\(appointmentDetail!.appointmentDate!.month)/\(appointmentDetail!.appointmentDate!.year)"
        patientID.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = false
        GenderTextField.isUserInteractionEnabled = false
        ageTextField.isUserInteractionEnabled = false
        clinicName.isUserInteractionEnabled = false
        doctorName.isUserInteractionEnabled = false
        dateTextField.isUserInteractionEnabled = false
      }
    }
    
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
            clinicName.resignFirstResponder()
            doctorName.resignFirstResponder()
            timing.resignFirstResponder()
        }
        
        @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            
            if(GenderTextField.isFirstResponder){
                GenderTextField?.resignFirstResponder()
                if(GenderTextField.text?.count == 0){
                    GenderTextField.text = genderList[0]
                }
            }else if(clinicName.isFirstResponder){
                if(clinicName.text?.count == 0){
                    clinicName.text = clinicNameList[0].clinicName
                }
                clinicName.resignFirstResponder()
            }else if(doctorName.isFirstResponder){
                if(doctorName.text?.count == 0){
                    doctorName.text = drNameList[0].doctorName
                }
                selectedDoctor = 0
                doctorName.resignFirstResponder()
            }else if(dateTextField.isFirstResponder){
                dateTextField?.resignFirstResponder()
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
                dateTextField?.text = "\(day)/\(month)/\(datePicker.date.year)"
            }
            else{
                if(timing.text?.count == 0){
                    timing.text = TimingSlot[0]
                }
                timing.resignFirstResponder()
            }
           }
       }


extension NewAppointmentVC : SorryViewDelegate {
    func didTapOnOK() {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.loadData()
    }
}

//MARK: Actions
extension NewAppointmentVC {
    
    @IBAction func didTapOnCreate(_ sender: UIButton){
        if(validatePatientID() && validateName() && validateGender() && validateAge() && validateClinic() && validateDr() && validateTiming() && validateDate()){
            if(appointmentDetail != nil){
                
            }else{
                addNewAppointment()
            }
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
    
    func validateDate() -> Bool{
        if(dateTextField.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter date", duration: .short)
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
            return TimingSlot.count
            
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
            return clinicNameList[row].clinicName
        case doctorPickerView:
            return drNameList[row].doctorName
        case timingPickerView:
            return TimingSlot[row]
            
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
            clinicName.text = clinicNameList[row].clinicName
        case doctorPickerView:
            doctorName.text = drNameList[row].doctorName
        case timingPickerView:
            timing.text = TimingSlot[row]
        default:
            break
        }
    }
}


//MARK: API CALL
extension NewAppointmentVC {
    
    func addNewAppointment(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        let first5 = String((timing.text!).prefix(5))
        let tim = dateTextField.text! + " \(first5)"
        
        AppointmentManager.sharedInstance.NewAppointment(patientID: patientID.text!, appointmentStart: tim, name: nameTextField.text!, reason: reasonOfAppointment.text, doctorID: "\(drNameList[selectedDoctor!].doctorID!)", completionHandler: {(success,data,error)in
            alert.dismiss(animated: true, completion: nil)
            
            if(success){
                SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have successfully added a new Appointment.",buttonText: "OK")
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
    
    
    func getDoctorList(){
        
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.medium
//        loadingIndicator.startAnimating();
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
        
        let id = selectedClinic?.clinicID
        
        AppointmentManager.sharedInstance.doctorList(clinicID: id, completionHandler: {(success,data,error) in
           // alert.dismiss(animated: true, completion: nil)
            if(success){
                self.drNameList = data!
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
}
