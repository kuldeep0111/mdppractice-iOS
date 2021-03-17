//
//  BlockDateVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit
import TTGSnackbar

protocol BlockDateVCDelegate {
    func updateCalender()
}

class BlockDateVC: UIViewController {

    
    var delegate: BlockDateVCDelegate?
    @IBOutlet weak var clinicNameTFD : MDPTextField!{
        didSet{
            clinicNameTFD.isUserInteractionEnabled = false
        }
    }
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
    
    var clinicList : [ClinicListModel] = []
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    var startTimePicker = UIDatePicker()
    var endTimePicker = UIDatePicker()
    
    var key : Int?
    var clinicId : Int?
    var startDate: Date = Date()
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}

//MARK: LifeCycle
extension BlockDateVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clinicList = ClinicManager.sharedInstance.clinicArray
        self.title = "Block Date"
        self.navigationController?.navigationBar.isHidden = false
        clinicNamePickerView.dataSource = self
        clinicNamePickerView.delegate = self
        clinicNameTFD.inputAccessoryView = pickerToolbar
        clinicNameTFD.inputView = clinicNamePickerView
        clinicNameTFD.delegate = self
        clinicNameTFD.text = selectedClinic?.clinicName
        
        startTimeTFD.delegate = self
        endDateTFD.delegate = self
        startDateTFD.delegate = self
        endTimeTFD.delegate = self
        
        createUIToolBar()
        startDatePicker.datePickerMode = .date
        startDatePicker.preferredDatePickerStyle = .wheels
        startDateTFD?.inputAccessoryView = pickerToolbar
        startDateTFD?.inputView = startDatePicker
        startDateTFD.delegate = self
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        startDateTFD.text = dateFormatter.string(from: startDate)
        
        endDatePicker.datePickerMode = .date
        endDatePicker.preferredDatePickerStyle = .wheels
        endDateTFD?.inputAccessoryView = pickerToolbar
        endDateTFD?.inputView = endDatePicker
        endDateTFD.delegate = self
        
        startTimePicker.datePickerMode = .time
        startTimePicker.preferredDatePickerStyle = .wheels
        startTimeTFD?.inputAccessoryView = pickerToolbar
        startTimeTFD?.inputView = startTimePicker
        startTimeTFD.delegate = self
        
        endTimePicker.datePickerMode = .time
        endTimePicker.preferredDatePickerStyle = .wheels
        endTimeTFD?.inputAccessoryView = pickerToolbar
        endTimeTFD?.inputView = endTimePicker
        endTimeTFD.delegate = self
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

extension BlockDateVC: SorryViewDelegate {
    func didTapOnOK() {
        self.navigationController?.popViewController(animated: true)
        delegate?.updateCalender()
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
        
        if(validateClinic() && validateStartDate() && validateEndDate()){
            if(checkBtn.isSelected){
                blockDate()
            }else{
                if(validateStartTime() && validateEndTime()) {
                    blockDate()
                }
            }
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
            
            let dat = formatter.date(from: startDateTFD.text!)
            let dat1 = formatter.date(from: endDateTFD.text!)
            if(dat! > dat1!){
                let snackbar = TTGSnackbar(message: "End date will be not greater than start date", duration: .middle)
                snackbar.show()
                return false
            }
            
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
            
            let starttime = ((startTimeTFD.text!).timeFormate24Hrs()).replace(":", with: "")
            let t1 = Int(starttime)

            let endtime = ((endTimeTFD.text!).timeFormate24Hrs()).replace(":", with: "")
            let t2 = Int(endtime)
//            if(t1! > t2!){
//                let snackbar = TTGSnackbar(message: "start time will be not greater than end time", duration: .middle)
//                snackbar.show()
//                return false
//            }
            
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
      
        return clinicList[row].clinicName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        clinicNameTFD.text = clinicList[row].clinicName
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
            clinicNameTFD.resignFirstResponder()
            startDateTFD?.resignFirstResponder()
            endDateTFD.resignFirstResponder()
            startTimeTFD.resignFirstResponder()
            endTimeTFD.resignFirstResponder()
        }
        
        @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            if(startDateTFD.isFirstResponder){
                startDateTFD?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.dateFormat = "dd/MM/yyyy"
                startDateTFD?.text = formatter.string(from: startDatePicker.date)
            }else if(endDateTFD.isFirstResponder){
                endDateTFD?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.dateFormat = "dd/MM/yyyy"
                endDateTFD?.text = formatter.string(from: endDatePicker.date)
            }else if(startTimeTFD.isFirstResponder){
                startTimeTFD?.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                startTimeTFD?.text = formatter.string(from: startTimePicker.date)
            }else if(endTimeTFD.isFirstResponder){
                endTimeTFD.resignFirstResponder()
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                endTimeTFD?.text = formatter.string(from: endTimePicker.date)

            }else{
                clinicNameTFD.resignFirstResponder()
            }
        }
    }


//MARK: API Call
extension BlockDateVC {
    
    func blockDate(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)
        
        let selectStarttime = checkBtn.isSelected ? " 00:00" : " \((startTimeTFD.text!).timeFormate24Hrs())"
        let selectEndtime = checkBtn.isSelected ? " 00:00" : " \((endTimeTFD.text!).timeFormate24Hrs())"
        
        let startdate = startDateTFD.text! + selectStarttime
        let enddate = endDateTFD.text! + selectEndtime
        
        AppointmentManager.sharedInstance.BlockDates(startDate: startdate, endDate: enddate, clinicID: clinicId!, completionHandler: {
                        (success,data,error) in
                alert.dismiss(animated: false, completion: nil)
            if(success){
                SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have successfully block the date.", buttonText: "OK")
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
}
