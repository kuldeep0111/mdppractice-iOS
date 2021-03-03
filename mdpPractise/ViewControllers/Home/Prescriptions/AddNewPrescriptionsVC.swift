//
//  AddNewPrescriptionsVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/03/21.
//

import UIKit
import TTGSnackbar

class AddNewPrescriptionsVC: UIViewController {

    @IBOutlet weak var doctorName : MDPTextField!
    @IBOutlet weak var date : MDPTextField!
    @IBOutlet weak var drugName : MDPTextField!
    @IBOutlet weak var strength : MDPTextField!
    @IBOutlet weak var measure : MDPTextField!
    @IBOutlet weak var duration : MDPTextField!
    @IBOutlet weak var frequency : MDPTextField!
    @IBOutlet weak var afterFoodBtn : UIButton!
    @IBOutlet weak var beforeFoodBtn : UIButton!
    @IBOutlet weak var submitBtn : UIButton!{
        didSet{
            submitBtn.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    
    
    var datePicker = UIDatePicker()
    var pickerToolbar: UIToolbar?
    
    var drugNamePicker =  UIPickerView()
    var measurePicker =  UIPickerView()
    
    var drugNameList  = ["ABCS","BHDH","CEHDH"]
    var measureList  = ["MG","MG"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Prescription"
        
        createUIToolBar()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        date.inputAccessoryView = pickerToolbar
        date.inputView = datePicker
        
        drugNamePicker = UIPickerView()
        drugNamePicker.dataSource = self
        drugNamePicker.delegate = self
        drugNamePicker.backgroundColor = .white
        
        drugName.inputAccessoryView = pickerToolbar
        drugName.inputView = drugNamePicker
        
        measurePicker = UIPickerView()
        measurePicker.dataSource = self
        measurePicker.delegate = self
        measurePicker.backgroundColor = .white
        
        measure.inputAccessoryView = pickerToolbar
        measure.inputView = measurePicker
        measure.text = measureList[0]

        afterFoodBtn.isSelected = true
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


//MARK: Validate
extension AddNewPrescriptionsVC {
    
    
    func validateDoctorName() -> Bool{
        if(doctorName.text!.count > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter doctor name.", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateDate() -> Bool{
        if(date.text?.count != 0){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter date.", duration: .short)
            snackbar.show()
            return false
        }
    }

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

    func validateDuration() -> Bool{
        if(duration.text!.count > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter duration", duration: .short)
            snackbar.show()
            return false
        }
    }

    func validateFrequency() -> Bool{
        if(frequency.text!.count > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter frequency.", duration: .short)
            snackbar.show()
            return false
        }
    }
}

//MARK: Keyboard Events
extension AddNewPrescriptionsVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}


//MARK: Action's

extension AddNewPrescriptionsVC {
    
    @IBAction func didTapOnAfterFood(_ sender : UIButton){
        if afterFoodBtn.isSelected == false {
            afterFoodBtn.isSelected = true
            beforeFoodBtn.isSelected = false
        }
    }
    
    @IBAction func didTapOnBeforeFood(_ sender : UIButton){
        if beforeFoodBtn.isSelected == false {
            beforeFoodBtn.isSelected = true
            afterFoodBtn.isSelected = false
        }
    }
    
    @IBAction func didTapOnSubmitd(_ sender : UIButton){
        
        if(validateDoctorName() && validateDate() && validateDrugName() && validateStrength() && validateMeasure() && validateDuration() && validateFrequency()){
            SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have successfully added a New Prescription.", buttonText: "OK")
        }
    }
}

extension AddNewPrescriptionsVC : SorryViewDelegate {
    func didTapOnOK() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: UIDatePicker
extension AddNewPrescriptionsVC {
    
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
            date.resignFirstResponder()
            measure.resignFirstResponder()
            drugName.resignFirstResponder()
        }
        
        @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            if(date.isFirstResponder){
                date?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                date?.text = formatter.string(from: datePicker.date)
            }else if(measure.isFirstResponder){
                if(measure.text?.count == 0){
                    measure.text = measureList[0]
                }
                measure.resignFirstResponder()
            }else{
                if(drugName.text?.count == 0){
                   drugName.text = drugNameList[0]
                }
                drugName.resignFirstResponder()
            }
        }
    }


//MARK: UIPickerView
extension AddNewPrescriptionsVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch pickerView {
        case drugNamePicker:
            return drugNameList.count
        case measurePicker:
            return measureList.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case drugNamePicker:
            return drugNameList[row]
        case measurePicker:
            return measureList[row]
            
        default:
            break
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch pickerView {
        case drugNamePicker:
            drugName.text = drugNameList[row]
        case measurePicker:
            measure.text = measureList[row]
        default:
            break
        }
        //self.view.endEditing(true)
    }
}
