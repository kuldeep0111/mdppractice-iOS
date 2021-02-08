//
//  ConsentVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit

class ConsentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Consent Form"
         navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addForm))
    }
}

//MARK: Action's
extension ConsentVC {
    @objc func addForm(){
        ConsentFormView.showPopup(parentVC: self)
    }
}

extension ConsentVC : ConsentFormViewDelegate {
    func didTapOnCovidConsent() {
        NewConsentFormView.showPopup(parentVC: self,titleText: "Covid Consent")
    }
    
    func didTapOnGenralConsent() {
        NewConsentFormView.showPopup(parentVC: self,titleText: "General Consent")
    }
}

extension ConsentVC : NewConsentFormViewDelegate {
    func didTapOnSave() {
        
    }
}
