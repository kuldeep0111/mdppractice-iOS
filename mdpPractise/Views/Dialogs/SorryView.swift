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
    
    var subText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subTitle.text = "You have successfully added a \(subText)"
    }
    
    @IBAction func didTapOnConfirm(_ sender: UIButton!){
        self.dismiss(animated: true, completion: nil)
        delegate?.didTapOnOK()
    }
    
    static func showPopup(parentVC: UIViewController, subText : String){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "SorryView") as? SorryView {
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        popupViewController.delegate = parentVC as? SorryViewDelegate
        popupViewController.subText = subText
        parentVC.present(popupViewController, animated: true)
      }
  }
}
