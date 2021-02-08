//
//  ConsentFormView.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit

protocol ConsentFormViewDelegate {
    func didTapOnCovidConsent()
    func didTapOnGenralConsent()
}

class ConsentFormView: UIViewController {

    var delegate : ConsentFormViewDelegate?
    
    @IBOutlet weak var containerView : UIView!{
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var covidView : UIView!{
        didSet {
            covidView.layer.cornerRadius = 8
            covidView.layer.borderWidth = 2
            covidView.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var genralView : UIView!{
        didSet {
            genralView.layer.cornerRadius = 8
            genralView.layer.borderWidth = 2
            genralView.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMe))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func dismissMe() {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func didTapOnCovidConsent(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        delegate?.didTapOnCovidConsent()
    }
    
    @IBAction func didTapOnGenralConsent(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        delegate?.didTapOnGenralConsent()
    }
    
    static func showPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "ConsentFormView") as? ConsentFormView {
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        popupViewController.delegate = parentVC as? ConsentFormViewDelegate
        parentVC.present(popupViewController, animated: true)
        }
      }
}
