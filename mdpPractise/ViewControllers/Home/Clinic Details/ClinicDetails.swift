//
//  SetupClinicVC.swift
//  mdppractice
//
//  Created by rahul on 28/01/21.
//

import UIKit
import TTGSnackbar

class ClinicDetails: UIViewController {

    @IBOutlet weak var clinicName : MDPTextField!
    @IBOutlet weak var ownerName : MDPTextField!
    @IBOutlet weak var noOfChairs : MDPTextField!
    @IBOutlet weak var location : UILabel!
    @IBOutlet weak var address1TextField : MDPTextField!
    @IBOutlet weak var address2TextField : MDPTextField!
    @IBOutlet weak var pincodeTextField : MDPTextField!
    @IBOutlet weak var cityTextField : MDPTextField!
    @IBOutlet weak var stateTextField : MDPTextField!
    @IBOutlet weak var councelNoTextField : MDPTextField!
    @IBOutlet weak var locationButton : UIButton!
    @IBOutlet weak var approvalBtn : UIButton!{
        didSet{
            approvalBtn.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var checkButton : UIButton!{
        didSet{
            checkButton.isSelected  = true
        }
    }
    @IBOutlet weak var certificateImgName: UILabel!
    @IBOutlet weak var checkTitle : UILabel!
    
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    var imagePicker = UIImagePickerController()
       
    var isAlreadyFeel = false
    
}

//MARK: LifeCycle
extension ClinicDetails{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Clinic Details"
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
    }
}

//MARK: Helping Method
extension ClinicDetails {
    
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
        self.ownerName.isUserInteractionEnabled = false
        self.noOfChairs.isUserInteractionEnabled = false
        self.approvalBtn.setTitle("SAVE", for: .normal)
        self.approvalBtn.isHidden = true
        self.locationButton.isUserInteractionEnabled = false
        self.checkButton.isHidden = true
        self.checkTitle.text = ""
    }else{
        self.checkButton.isHidden = false
        self.checkTitle.text = "Subscribe to our newsletter and get updates from My Dental Plan"
        self.clinicName.isUserInteractionEnabled = true
        self.address1TextField.isUserInteractionEnabled = true
        self.address2TextField.isUserInteractionEnabled = true
        self.pincodeTextField.isUserInteractionEnabled = true
        self.cityTextField.isUserInteractionEnabled = false
        self.stateTextField.isUserInteractionEnabled = false
        self.councelNoTextField.isUserInteractionEnabled = true
        self.ownerName.isUserInteractionEnabled = true
        self.noOfChairs.isUserInteractionEnabled = true
        self.locationButton.isUserInteractionEnabled = true
        self.approvalBtn.isHidden = false
      }
    }
}

//MARK: UITextFieldDelegate
extension ClinicDetails : UITextFieldDelegate {
    
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
extension ClinicDetails {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 280
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}



//MARK: Action's
extension ClinicDetails {
    
    @IBAction func didTapOnCheck(_ sender: UIButton){
        
        if(checkButton.isSelected){
            checkButton.isSelected = false
        }else{
            checkButton.isSelected = true
        }
    }
    
    @objc func didTapOnEdit(){
        self.clinicName.isUserInteractionEnabled = true
        self.address1TextField.isUserInteractionEnabled = true
        self.address2TextField.isUserInteractionEnabled = true
        self.pincodeTextField.isUserInteractionEnabled = true
        self.cityTextField.isUserInteractionEnabled = false
        self.stateTextField.isUserInteractionEnabled = false
        self.ownerName.isUserInteractionEnabled = true
        self.noOfChairs.isUserInteractionEnabled = true
        self.approvalBtn.isHidden = false
        self.locationButton.isUserInteractionEnabled = true
    }
    
    @objc func didTapOnDelete(){
        
    }
    
    @IBAction func didTapOnApprovalBtn(_ sender: UIButton){
        
        if(validateName() && validateAddress1() && validatePin() && validateCity() && validateState() && validateCouncilNo()){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            mainTabBarController.modalPresentationStyle = .fullScreen
            self.present(mainTabBarController, animated: true, completion: nil)
        }else{
            
        }
    }
    
    @IBAction func didTapOnresistrationCertificateBtn(_ sender: UIButton){
        getImageFromGallery()
    }
    
    @IBAction func didTapOnLocationBtn(_ sender: UIButton){
        UIApplication.shared.open(URL(string:"https://www.google.com/maps/@42.585444,13.007813,6z")!)
            }
    }

//MARK: UIImagePickerControllerDelegate
extension ClinicDetails : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            certificateImgName.text = fileUrl.lastPathComponent
           picker.dismiss(animated: true)
    }}

//MARK: Helping Method

extension ClinicDetails {
    
    func getImageFromGallery(){
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    print("Button capture")
                    imagePicker.delegate = self
                    imagePicker.sourceType = .savedPhotosAlbum
                    imagePicker.allowsEditing = false
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
