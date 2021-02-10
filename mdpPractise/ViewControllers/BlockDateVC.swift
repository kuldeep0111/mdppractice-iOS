//
//  BlockDateVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit
import TTGSnackbar

class BlockDateVC: UIViewController {

    @IBOutlet weak var clinicNameTFD : MDPTextField!
    @IBOutlet weak var startDateTFD : MDPTextField!
    @IBOutlet weak var endDateTFD : MDPTextField!
    @IBOutlet weak var startTimeTFD : MDPTextField!
    @IBOutlet weak var endTimeTFD : MDPTextField!
    @IBOutlet weak var checkBtn : UIButton!
    @IBOutlet weak var saveBtn : UIButton!{
        didSet{
            saveBtn.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    
    var clinicNamePickerView = UIPickerView()
    var pickerToolbar: UIToolbar?
    
    var clinicList = ["Raghav Clinic","Rajiv Clinic"]
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    var startTimePicker = UIDatePicker()
    var endTimePicker = UIDatePicker()

}

//MARK: LifeCycle
extension BlockDateVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Block Date"
        clinicNamePickerView.dataSource = self
        clinicNamePickerView.delegate = self
        clinicNameTFD.inputAccessoryView = pickerToolbar
        clinicNameTFD.inputView = clinicNamePickerView
        clinicNameTFD.delegate = self
        startTimeTFD.delegate = self
        endDateTFD.delegate = self
        startDateTFD.delegate = self
        endTimeTFD.delegate = self
        
        createUIToolBar()
        startDatePicker.datePickerMode = .date
        startDatePicker.preferredDatePickerStyle = .wheels
        startDateTFD?.inputAccessoryView = pickerToolbar
        startDateTFD?.inputView = startDatePicker
        
        endDatePicker.datePickerMode = .date
        endDatePicker.preferredDatePickerStyle = .wheels
        endDateTFD?.inputAccessoryView = pickerToolbar
        endDateTFD?.inputView = endDatePicker
        
        startTimePicker.datePickerMode = .time
        startTimePicker.preferredDatePickerStyle = .wheels
        startTimeTFD?.inputAccessoryView = pickerToolbar
        startTimeTFD?.inputView = startTimePicker
        
        endTimePicker.datePickerMode = .date
        endTimePicker.preferredDatePickerStyle = .wheels
        endTimeTFD?.inputAccessoryView = pickerToolbar
        endTimeTFD?.inputView = endTimePicker
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
extension BlockDateVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}

//MARK: Action
extension BlockDateVC {
    
    @IBAction func didTapOnCheck(_ sender: UIButton){
        if(checkBtn.isSelected){
            checkBtn.isSelected = false
        }else{
            checkBtn.isSelected = true
        }
    }
    
    @IBAction func didTapOnSave(_ sender: UIButton){
        
        if(validateClinic() && validateStartDate() && validateEndDate() && validateStartTime() && validateEndTime()){
            
        }else{
            
        }
    }
}

//MARK: Validate Form
extension BlockDateVC {
    
    func validateClinic() -> Bool{
        if(clinicNameTFD.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter clinic name", duration: .short)
            snackbar.show()
            return false
        }
    }
    func validateStartDate() -> Bool{
        if(startDateTFD.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter start date", duration: .short)
            snackbar.show()
            return false
        }
    }
   
    func validateEndDate() -> Bool{
        if(endDateTFD.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter end date", duration: .short)
            snackbar.show()
            return false
        }
    }

    func validateStartTime() -> Bool{
        if(startTimeTFD.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter start time", duration: .short)
            snackbar.show()
            return false
        }
    }
   
    func validateEndTime() -> Bool{
        if(endTimeTFD.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter end time", duration: .short)
            snackbar.show()
            return false
        }
    }
}

//MARK: UITextFieldViewDelegate
extension BlockDateVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case clinicNameTFD:
            clinicNameTFD.resignFirstResponder()
            break
        case startDateTFD:
            startDateTFD.resignFirstResponder()
            break
        case endDateTFD:
            endDateTFD.resignFirstResponder()
            break
        case startTimeTFD:
            startTimeTFD.resignFirstResponder()
            break
        case endTimeTFD:
            endTimeTFD.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
}

//MARK: UIPickerViewDelegate
extension BlockDateVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
     
            return clinicList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
            return clinicList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            clinicNameTFD.text = clinicList[row]
        self.view.endEditing(true)
    }
}

//MARK: UIDatePicker
extension BlockDateVC {
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
            startDateTFD?.resignFirstResponder()
        }
        
        @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            if(startDateTFD.canResignFirstResponder){
                startDateTFD?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                startDateTFD?.text = formatter.string(from: startDatePicker.date)
            }else if(endDateTFD.canResignFirstResponder){
                endDateTFD?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                endDateTFD?.text = formatter.string(from: endDatePicker.date)
            }else if(startTimeTFD.canResignFirstResponder){
                startTimeTFD?.resignFirstResponder()
//                let formatter = DateFormatter()
//                formatter.dateStyle = .medium
//                endDateTFD?.text = startTimePicker.dateStyle.text
            }else{
                
            }
        }
    }
