//
//  SorryView.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit

protocol SorryViewDelegate {
    func didTapOnOK()
}

class SorryView: UIViewController {

    var delegate : SorryViewDelegate?
    
    @IBOutlet weak var boxTitle : UILabel!{
        didSet{
            boxTitle.text = "Success!"
        }
    }
    
    @IBOutlet weak var subTitle : UILabel!{
        didSet{
            subTitle.text = "You have successfully added a patient"
        }
    }
    
    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var confirmBtn : UIButton!{
        didSet{
            confirmBtn.layer.cornerRadius = 25
        }
    }
    
    var boxTitleText = "Success!"
    var subText = ""
    var buttonTitle = "OK"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxTitle.text = boxTitleText
        subTitle.text = "\(subText)"
        confirmBtn.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func didTapOnConfirm(_ sender: UIButton!){
        self.dismiss(animated: false, completion: nil)
        delegate?.didTapOnOK()
    }
    
    static func showPopup(parentVC: UIViewController,boxTitle : String, subText : String, buttonText: String){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "SorryView") as? SorryView {
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        popupViewController.delegate = parentVC as? SorryViewDelegate
        popupViewController.boxTitleText = boxTitle
        popupViewController.subText = subText
        popupViewController.buttonTitle = buttonText
        parentVC.present(popupViewController, animated: false)
      }
   }
}
