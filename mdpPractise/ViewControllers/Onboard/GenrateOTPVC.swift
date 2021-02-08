//
//  ViewController.swift
//  mdppractice
//
//  Created by rahul on 27/01/21.
//

import UIKit
import TTGSnackbar

class GenrateOTPVC: UIViewController {

    @IBOutlet weak var contentViewHeight : NSLayoutConstraint!
    @IBOutlet weak var mobileTextField : MDPTextField!
    @IBOutlet weak var countryCodeTextField : UITextField!
    @IBOutlet weak var genrateOTPBtn : UIButton!
    @IBOutlet weak var phoneError : UILabel!
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        //mobileTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            //mobileTextField.resignFirstResponder()
        }
    
}

//MARK: LifeCycle
extension GenrateOTPVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTextField.delegate = self
        
        countryCodeTextField.isUserInteractionEnabled = false
        genrateOTPBtn.layer.cornerRadius = 25
        addDoneButtonOnKeyboard()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: Keyboard Events
extension GenrateOTPVC {
    
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 240
    }

    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}


extension GenrateOTPVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        contentViewHeight.constant = contentViewHeight.constant + 200
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contentViewHeight.constant = contentViewHeight.constant - 200
    }
}

extension GenrateOTPVC {
    
    @IBAction func didTapOnGenrateOTpVC(_ sender: UIButton){
        print(mobileTextField.text!.count)
        if(mobileTextField.text?.count == 10){
            let story : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "OTPVerifyVC") as! OTPVerifyVC
            vc.mobileno = mobileTextField.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let snackbar = TTGSnackbar(message: "Please enter valid number", duration: .short)
            snackbar.show()
        }
    }
}
