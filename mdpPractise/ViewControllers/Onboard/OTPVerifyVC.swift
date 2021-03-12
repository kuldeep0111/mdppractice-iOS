//
//  OTPVerifyVC.swift
//  mdppractice
//
//  Created by rahul on 27/01/21.
//

import UIKit
import TTGSnackbar

class OTPVerifyVC: UIViewController {
    
    @IBOutlet weak var digit1text : MDPTextField!
    @IBOutlet weak var digit2text : MDPTextField!
    @IBOutlet weak var digit3text : MDPTextField!
    @IBOutlet weak var digit4text : MDPTextField!
    @IBOutlet weak var verifyBtn : UIButton!
    @IBOutlet weak var mobileNoText : UILabel!{
        didSet{
            mobileNoText.text = "Please type the verificaiton code sent to +91 \(mobileno)"
        }
    }
    @IBOutlet weak var bottomSpace : NSLayoutConstraint!
    @IBOutlet weak var recentCodeView : UIView!
    @IBOutlet weak var timerView : UIView!
    @IBOutlet weak var timeLabel : UILabel!
    var mobileno = ""
    
    var count = 30
    
    func setupUI(){
        verifyBtn.layer.cornerRadius = 25
        recentCodeView.isHidden = true
        digit1text.delegate = self
        digit2text.delegate = self
        digit3text.delegate = self
        digit4text.delegate = self
        
        
        digit1text.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        digit2text.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        digit3text.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        digit4text.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
}

//MARK: LifeCycle
extension OTPVerifyVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
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
extension OTPVerifyVC {
    @objc func keyboardWillAppear() {
        bottomSpace.constant = 240
    }
    
    @objc func keyboardWillDisappear() {
        bottomSpace.constant = 20
    }
}

//MARK: Action's
extension OTPVerifyVC {
    
    @objc func update() {
        if(count > 0) {
            count = count - 1
            timeLabel.text = String(count) + " seconds remaining..."
            if(count == 0) {
                timerView.isHidden = true
                recentCodeView.isHidden = false
            }else{
                timerView.isHidden = false
                recentCodeView.isHidden = true
            }
        }
    }
    
    @IBAction func didTapOnVerify(_ sender: UIButton){
        if (digit4text.text?.count != 0) {
            verifyOTP()
            
        }else{
            let snackbar = TTGSnackbar(message: "Please enter OTP", duration: .short)
            snackbar.show()
        }
    }
    
    @IBAction func didTapOnRecentCode(_ sender: UIButton){
        count = 30
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
}

extension OTPVerifyVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        print(text?.utf16.count ?? 0)
        if (text?.utf16.count ?? 0) >= 1{
            switch textField{
            case digit1text:
                digit2text.becomeFirstResponder()
            case digit2text:
                digit3text.becomeFirstResponder()
            case digit3text:
                digit4text.becomeFirstResponder()
            case digit4text:
                digit4text.resignFirstResponder()
            default:
                break
            }
        }else{
            switch textField{
            case digit4text:
                digit3text.becomeFirstResponder()
            case digit3text:
                digit2text.becomeFirstResponder()
            case digit2text:
                digit1text.becomeFirstResponder()
            default:
                break
            }
        }
    }
}


//MARK: API CALL

extension OTPVerifyVC {
    
    func verifyOTP(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
        AuthenticationManager.sharedInstance.login(String(mobileno)) { (successful, response, error) in
            self.dismiss(animated: true, completion: nil)
            
            if successful{
                print("SUCCESS")
                
                var userType = 0
                
                var prospectid = 0
                
                
                if let dict = response?.dictionaryObject {
                    let id = (dict["prospectid"] as? NSString)?.intValue
                    prospectid = Int(id ?? 0)
                    let clinicCount = (dict["clinic_count"] as? NSString)?.intValue
                    if(response!["usertype"] == "prospect" && prospectid == 0) {
                        userType = 2
                    }else if(response!["usertype"] == "prospect" && prospectid > 0){
                        if(clinicCount! > 0){
                            userType = 4
                        }
                        else{
                            userType = 3
                        }
                    }
                    else if(dict["providerid"] != nil) {
                        userType = 1
                        UserDefaults.standard.set(dict["providerid"], forKey: "providerid")
                        UserDefaults.standard.set(dict["cell"], forKey: "cell")
                        UserDefaults.standard.set(dict["email"], forKey: "email")
                        UserDefaults.standard.set(dict["providername"], forKey: "providerid")
                        UserDefaults.standard.set(dict["providerid"], forKey: "providername")
                        UserDefaults.standard.set(dict["providerid"], forKey: "providerid")
                        UserDefaults.standard.set(dict["providerid"], forKey: "providerid")
                        UserDefaults.standard.set(dict["providerid"], forKey: "providerid")
                        UserDefaults.standard.set(dict["providerid"], forKey: "providerid")
                        UserDefaults.standard.set(dict["providerid"], forKey: "providerid")
                    }
                }
                
                
                switch userType {
                case 1:
                    let rootVC = mdpStoryBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                    UIApplication.shared.windows.first?.rootViewController = rootVC
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    break
                case 2:
                    let vc = mdpStoryBoard.instantiateViewController(identifier: "SignUpVC") as SignUpVC
                    vc.mobileNo = self.mobileno
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    break
                case 3:
                    let vc = mdpStoryBoard.instantiateViewController(identifier: "ThanksPageVC") as ThanksPageVC
                    vc.prospectid = "\(prospectid)"
                    vc.mobileNo = self.mobileno
                    let navVC = UINavigationController.init(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    //self.navigationController?.pushViewController(vc, animated: true)
                    self.present(navVC, animated: true, completion: nil)
                    break
                case 4:
                    let vc = mdpStoryBoard.instantiateViewController(identifier: "AnalyseVC") as AnalyseVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                }
                return;
            }
            
            let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
            snackbar.show()
        }
        
    }
}
