//
//  AddStaffMemberVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class AddStaffMemberVC: UIViewController {

    @IBOutlet weak var nameTextField : MDPTextField!
    @IBOutlet weak var streamTextField : MDPTextField!
    @IBOutlet weak var madicalTextField : MDPTextField!
    @IBOutlet weak var phoneNumberTfd : MDPTextField!
    @IBOutlet weak var designationTfd : MDPTextField!
    
    @IBOutlet weak var MtoFView: UIView!{
        didSet{
            MtoFView.layer.cornerRadius = 8.0
            MtoFView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            MtoFView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var saturdayView: UIView!{
        didSet{
            saturdayView.layer.cornerRadius = 8.0
            saturdayView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            saturdayView.layer.borderWidth = 1
        }
    }

    
    @IBOutlet weak var sundayView: UIView!{
        didSet{
            sundayView.layer.cornerRadius = 8.0
            sundayView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            sundayView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var time1View: UIView!{
        didSet{
            time1View.layer.cornerRadius = 8.0
            time1View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time1View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time1View.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var time2View: UIView!{
        didSet{
            time2View.layer.cornerRadius = 8.0
            time2View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time2View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time2View.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var time3View: UIView!{
        didSet{
            time3View.layer.cornerRadius = 8.0
            time3View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time3View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time3View.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var time4View: UIView!{
        didSet{
            time4View.layer.cornerRadius = 8.0
            time4View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time4View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time4View.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var time5View: UIView!{
        didSet{
            time5View.layer.cornerRadius = 8.0
            time5View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time5View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time5View.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var time6View: UIView!{
        didSet{
            time6View.layer.cornerRadius = 8.0
            time6View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time6View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time6View.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var time7View: UIView!{
        didSet{
            time7View.layer.cornerRadius = 8.0
            time7View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time7View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time7View.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var time8View: UIView!{
        didSet{
            time8View.layer.cornerRadius = 8.0
            time8View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time8View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time8View.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var time9View: UIView!{
        didSet{
            time9View.layer.cornerRadius = 8.0
            time9View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time9View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time9View.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var time10View: UIView!{
        didSet{
            time10View.layer.cornerRadius = 8.0
            time10View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time10View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time10View.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var time11View: UIView!{
        didSet{
            time11View.layer.cornerRadius = 8.0
            time11View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time11View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time11View.layer.borderWidth = 1
        }
    }

    @IBOutlet weak var time12View: UIView!{
        didSet{
            time12View.layer.cornerRadius = 8.0
            time12View.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            time12View.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            time12View.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    
    
    var streamPickerView = UIPickerView()
    var medicalPickerView = UIPickerView()
    var pickerToolbar: UIToolbar?

    var streamList = ["Medical","Non Medical"]
    var medicalList = ["Permanent","Non Permanent"]
}

//MARK: LifeCycle
extension AddStaffMemberVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Staff Member"
        streamPickerView = UIPickerView()
        streamPickerView.dataSource = self
        streamPickerView.delegate = self
        streamPickerView.backgroundColor = UIColor.white

        medicalPickerView = UIPickerView()
        medicalPickerView.dataSource = self
        medicalPickerView.delegate = self
        medicalPickerView.backgroundColor = UIColor.white
        
        streamTextField.inputAccessoryView = pickerToolbar
        madicalTextField.inputAccessoryView = pickerToolbar
        
        streamTextField.inputView = streamPickerView
        madicalTextField.inputView = medicalPickerView
        nameTextField.delegate = self
        streamTextField.delegate = self
        madicalTextField.delegate = self
        phoneNumberTfd.delegate = self
        designationTfd.delegate = self
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
extension AddStaffMemberVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}


//MARK: UITextFieldViewDelegate

extension AddStaffMemberVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField
        {
        case nameTextField:
            nameTextField.resignFirstResponder()
            break
        case streamTextField:
            streamTextField.resignFirstResponder()
            break
        case madicalTextField:
            madicalTextField.resignFirstResponder()
            break
        case designationTfd:
            designationTfd.becomeFirstResponder()
            break
        case phoneNumberTfd:
            phoneNumberTfd.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: UIPickerView
extension AddStaffMemberVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch pickerView {
        case streamPickerView:
            return streamList.count
        case medicalPickerView:
            return medicalList.count

        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case streamPickerView:
            return streamList[row]
        case medicalPickerView:
            return medicalList[row]

        default:
            break
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch pickerView {
        case streamPickerView:
            streamTextField.text = streamList[row]
        case medicalPickerView:
            madicalTextField.text = medicalList[row]
        default:
            break
        }
        self.view.endEditing(true)
    }
}
