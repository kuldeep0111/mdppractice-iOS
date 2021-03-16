//
//  SetupClinicVC.swift
//  mdppractice
//
//  Created by rahul on 28/01/21.
//

import UIKit
import TTGSnackbar
import Photos

protocol SetupClinicVCDelegate {
    func updateClinicList()
}

class SetupClinicVC: UIViewController {

    var delegate : SetupClinicVCDelegate?
    
    @IBOutlet weak var clinicName : MDPTextField!
    @IBOutlet weak var address1TextField : MDPTextField!
    @IBOutlet weak var address2TextField : MDPTextField!
    @IBOutlet weak var pincodeTextField : MDPTextField!
    @IBOutlet weak var cityTextField : MDPTextField!
    @IBOutlet weak var stateTextField : MDPTextField!
    @IBOutlet weak var councelNoTextField : MDPTextField!
    @IBOutlet weak var councelNoError : UILabel!
    @IBOutlet weak var checkBtn : UIButton!{
        didSet{
            checkBtn.isSelected = true
        }
    }
    @IBOutlet weak var frontImgName : UILabel!
    @IBOutlet weak var interoirImgName : UILabel!
    @IBOutlet weak var certificateImageName : UILabel!
    @IBOutlet weak var checkText : UILabel!
    @IBOutlet weak var frontFacadeBtn : UIButton!
    @IBOutlet weak var clinicInteriorBtn : UIButton!
    @IBOutlet weak var resistrationCertificateBtn : UIButton!
    @IBOutlet weak var approvalBtn : UIButton!{
        didSet{
            approvalBtn.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var frondFacdView : UIView!{
        didSet{
            frondFacdView.layer.cornerRadius = 8.0
            frondFacdView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            frondFacdView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            frondFacdView.layer.borderWidth = 1

        }
    }
    @IBOutlet weak var interiorView : UIView!{
        didSet{
            interiorView.layer.cornerRadius = 8.0
            interiorView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            interiorView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            interiorView.layer.borderWidth = 1

        }
    }
    @IBOutlet weak var certificationView : UIView!{
        didSet{
            certificationView.layer.cornerRadius = 8.0
            certificationView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            certificationView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            certificationView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    var imagePicker = UIImagePickerController()
       
    var isAlreadyFeel = false
    var id: Int?
    
    var prospectedID = ""
    var mobileNo = ""
    
    var pickerToolbar: UIToolbar?
    var cityPicker =  UIPickerView()
    var statePicker =  UIPickerView()

    var cityList: [String] = []
    var stateList: [String] = []
}

//MARK: LifeCycle
extension SetupClinicVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Clinic Setup"
        self.navigationController?.navigationBar.isHidden = false
        
        getCities()
        
        createUIToolBar()
        
        cityPicker = UIPickerView()
        cityPicker.dataSource = self
        cityPicker.delegate = self
        cityPicker.backgroundColor = .white
        
        cityTextField.inputAccessoryView = pickerToolbar
        cityTextField.inputView = cityPicker
        
        statePicker = UIPickerView()
        statePicker.dataSource = self
        statePicker.delegate = self
        statePicker.backgroundColor = .white
        
        stateTextField.inputAccessoryView = pickerToolbar
        stateTextField.inputView = statePicker

        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        clinicName.delegate = self
        address1TextField.delegate = self
        address2TextField.delegate = self
        pincodeTextField.delegate = self
        cityTextField.delegate = self
        councelNoTextField.delegate = self
        setupPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.navigationBar.isHidden = true
    }
}

//MARK: Helping Method
extension SetupClinicVC {
    
   func setupPage(){
    if(isAlreadyFeel){
        
        let deleteButton = UIBarButtonItem(
            image: UIImage(named: "delete")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnDelete))
        let editButton = UIBarButtonItem(
            image: UIImage(named: "edit")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnEdit))

        navigationItem.rightBarButtonItems = [deleteButton,editButton]
        
        self.clinicName.isUserInteractionEnabled = false
        self.address1TextField.isUserInteractionEnabled = false
        self.address2TextField.isUserInteractionEnabled = false
        self.pincodeTextField.isUserInteractionEnabled = false
        self.cityTextField.isUserInteractionEnabled = false
        self.stateTextField.isUserInteractionEnabled = false
        self.councelNoTextField.isUserInteractionEnabled = false
        self.checkBtn.isUserInteractionEnabled = false
        self.frontFacadeBtn.isUserInteractionEnabled = false
        self.clinicInteriorBtn.isUserInteractionEnabled = false
        self.resistrationCertificateBtn.isUserInteractionEnabled = false
        self.approvalBtn.setTitle("SAVE", for: .normal)
        self.approvalBtn.isHidden = true
        self.checkBtn.isHidden = true
        self.checkText.text = ""
    }else{
        self.clinicName.isUserInteractionEnabled = true
        self.address1TextField.isUserInteractionEnabled = true
        self.address2TextField.isUserInteractionEnabled = true
        self.pincodeTextField.isUserInteractionEnabled = true
        self.cityTextField.isUserInteractionEnabled = true
        self.stateTextField.isUserInteractionEnabled = true
        self.councelNoTextField.isUserInteractionEnabled = true
        self.checkBtn.isUserInteractionEnabled = true
        self.frontFacadeBtn.isUserInteractionEnabled = true
        self.clinicInteriorBtn.isUserInteractionEnabled = true
        self.resistrationCertificateBtn.isUserInteractionEnabled = true
        self.approvalBtn.isHidden = false
        self.checkBtn.isHidden = false
        self.checkText.text = "Subscribe to our newsletter and get updates from My Dental Plan"
      }
    }
}

//MARK: UITextFieldDelegate
extension SetupClinicVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField
        {
        case clinicName:
            address1TextField.becomeFirstResponder()
            break
        case address1TextField:
            address2TextField.becomeFirstResponder()
            break
        case address2TextField:
            pincodeTextField.becomeFirstResponder()
        case pincodeTextField:
            cityTextField.becomeFirstResponder()
            break
        case cityTextField:
            stateTextField.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}


//MARK: Keyboard Events
extension SetupClinicVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}



//MARK: Action's
extension SetupClinicVC {
    
    @objc func didTapOnEdit(){
        self.clinicName.isUserInteractionEnabled = true
        self.address1TextField.isUserInteractionEnabled = true
        self.address2TextField.isUserInteractionEnabled = true
        self.pincodeTextField.isUserInteractionEnabled = true
        self.cityTextField.isUserInteractionEnabled = true
        self.stateTextField.isUserInteractionEnabled = true
        self.councelNoTextField.isUserInteractionEnabled = true
        self.checkBtn.isUserInteractionEnabled = true
        self.frontFacadeBtn.isUserInteractionEnabled = true
        self.clinicInteriorBtn.isUserInteractionEnabled = true
        self.resistrationCertificateBtn.isUserInteractionEnabled = true
        self.approvalBtn.isHidden = false
        self.checkBtn.isHidden = false
        self.checkText.text = "Subscribe to our newsletter and get updates from My Dental Plan"
    }
    
    @objc func didTapOnDelete(){
        
    }

    
    @IBAction func didTapOnCheck(_ sender: UIButton){
        if (checkBtn.isSelected == true) {
            checkBtn.isSelected = false
        }else{
            checkBtn.isSelected = true
        }
    }
    
    @IBAction func didTapOnFrontFacade(_ sender: UIButton){
        id = 0
        getImageFromGallery()
    }
    
    @IBAction func didTapOnClinicInteriorBtn(_ sender: UIButton){
        id = 1
        getImageFromGallery()
    }
    
    @IBAction func didTapOnApprovalBtn(_ sender: UIButton){
        
        if(validateName() && validateAddress1() && validatePin() && validateCity() && validateState() && validateCouncilNo()){
            
            addClinicCall()
            
//            let vc = mdpStoryBoard.instantiateViewController(identifier: "AnalyseVC") as! AnalyseVC
//            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
    
    @IBAction func didTapOnresistrationCertificateBtn(_ sender: UIButton){
        id = 2
        getImageFromGallery()
    }
}

//MARK: UIImagePickerControllerDelegate
extension SetupClinicVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        
        switch id {
        case 0:
            frontImgName.text = fileUrl.lastPathComponent
            break
        case 1:
            interoirImgName.text = fileUrl.lastPathComponent
            break
        case 2:
            certificateImageName.text = fileUrl.lastPathComponent
            break
        default:
            break
        }
           picker.dismiss(animated: true)
    }}

//MARK: Helping Method

extension SetupClinicVC {
    
    func getImageFromGallery(){
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    print("Button capture")
                    present(imagePicker, animated: true, completion: nil)
                }

        
    }
    
    func validateName() -> Bool{
        if(clinicName.text?.count ?? 0 > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter clinic name", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateAddress1() -> Bool{
        if(address1TextField.text?.count ?? 0 > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter address", duration: .short)
            snackbar.show()
            return false
        }
    }

    
    func validatePin() -> Bool{
        if(pincodeTextField.text?.count == 6){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter valid PIN", duration: .short)
            snackbar.show()
            return false
        }
    }

    func validateCity() -> Bool{
        if(cityTextField.text?.count ?? 0 > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter city", duration: .short)
            snackbar.show()
            return false
        }
    }
 
    func validateState() -> Bool{
        if(stateTextField.text?.count ?? 0 > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter state", duration: .short)
            snackbar.show()
            return false
        }
    }
    
    func validateCouncilNo() -> Bool{
        if(councelNoTextField.text?.count ?? 0 > 2){
            return true
        }else{
            let snackbar = TTGSnackbar(message: "Please enter council No", duration: .short)
            snackbar.show()
            return false
        }
    }
}

//MARK: UIDatePicker
extension SetupClinicVC {
    
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
            cityTextField.resignFirstResponder()
            stateTextField.resignFirstResponder()
        }
        
        @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
            if(cityTextField.isFirstResponder){
                if(cityTextField.text?.count == 0){
                    cityTextField.text = cityList[0]
                }
                cityTextField.resignFirstResponder()

            }else if(stateTextField.isFirstResponder){
                if(stateTextField.text?.count == 0){
                    stateTextField.text = stateList[0]
                }
                stateTextField.resignFirstResponder()
            }
        }
    }


//MARK: UIPickerView
extension SetupClinicVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch pickerView {
        case cityPicker:
            return cityList.count
        case statePicker:
            return stateList.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case cityPicker:
            return cityList[row]
        case statePicker:
            return stateList[row]
            
        default:
            break
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch pickerView {
        case cityPicker:
            cityTextField.text = cityList[row]
        case statePicker:
            stateTextField.text = stateList[row]
        default:
            break
        }
        //self.view.endEditing(true)
    }
}

extension SetupClinicVC : SorryViewDelegate {
    func didTapOnOK() {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.updateClinicList()
    }
}

//MARK: API CALL
extension SetupClinicVC {
    
    func addClinicCall(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)

        
        ClinicManager.sharedInstance.AddNewClinic(prospectedID: prospectedID, mobileNo: mobileNo, name: clinicName.text!, address1: address1TextField.text!, address2: address2TextField.text!, city: cityTextField.text!, state: stateTextField.text!, pin: pincodeTextField.text!, email: "email") {(successful, user, error) in
            alert.dismiss(animated: false, completion: nil)
            if(successful){
                 print("Success")
                if(self.prospectedID != ""){
                    UserDefaults.standard.setValue(4, forKey: "userType")
                    let vc = mdpStoryBoard.instantiateViewController(identifier: "AnalyseVC") as AnalyseVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)

                }else{
                    
                        SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have successfully added a clinic.", buttonText: "OK")
//                    SorryView.showPopup(parentVC: self, boxTitle: "Success!", subText: "You have successfully added a clinic.", buttonText: "OK")
                }
            }else{
                let snackbar = TTGSnackbar(message: error?.description ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        }
    }
    
    func getCities(){
     
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        ClinicManager.sharedInstance.getCity() {(successful, user, error) in
            self.dismiss(animated: true, completion: nil)
            if(successful){
                self.cityList = user
                self.getStates()
            }else{
                let snackbar = TTGSnackbar(message: error?.description ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        }
    }
    
    func getStates(){
     
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)
        
        ClinicManager.sharedInstance.getState() {(successful, user, error) in
            self.dismiss(animated: false, completion: nil)
            if(successful){
                self.stateList = user
                 print("Success")
            
            }else{
                let snackbar = TTGSnackbar(message: error?.description ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        }
    }
}
