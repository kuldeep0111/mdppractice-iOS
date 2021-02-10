//
//  AddHolidays.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class AddHolidays: UIViewController {

    @IBOutlet weak var startDateTFD : MDPTextField!
    @IBOutlet weak var endDateTFD : MDPTextField!
    @IBOutlet weak var checkBtn : UIButton!
    @IBOutlet weak var saveBtn : UIButton!
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    var pickerToolbar: UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Holiday"
        saveBtn.layer.cornerRadius = 25
        createUIToolBar()
        startDatePicker.datePickerMode = .date
        startDatePicker.preferredDatePickerStyle = .wheels
        startDateTFD?.inputAccessoryView = pickerToolbar
        startDateTFD?.inputView = startDatePicker
        //startDateTFD.delegate = self
        
        endDatePicker.datePickerMode = .date
        endDatePicker.preferredDatePickerStyle = .wheels
        endDateTFD?.inputAccessoryView = pickerToolbar
        endDateTFD?.inputView = endDatePicker
        //endDateTFD.delegate = self
    }
    
    @IBAction func didTapOnCheck(_ sender: UIButton){
        if(checkBtn.isSelected){
            checkBtn.isSelected = false
        }else{
            checkBtn.isSelected = true
        }
    }
    
    @IBAction func didTapOnSave(_ sender: UIButton){
        
    }
}


//MARK: UIDatePicker
extension AddHolidays {
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
            endDateTFD.resignFirstResponder()
        }
        
        @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            if(startDateTFD.isFirstResponder){
                startDateTFD?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                startDateTFD?.text = formatter.string(from: startDatePicker.date)
            }else if(endDateTFD.isFirstResponder){
                endDateTFD?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                endDateTFD?.text = formatter.string(from: endDatePicker.date)
            }
        }
    }
