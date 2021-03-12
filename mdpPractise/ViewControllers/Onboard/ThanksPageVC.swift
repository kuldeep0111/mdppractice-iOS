//
//  ThanksPageVC.swift
//  mdppractice
//
//  Created by rahul on 28/01/21.
//

import UIKit

class ThanksPageVC: UIViewController {

    
    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
        }
    }
    
    @IBOutlet weak var setupClinicButton : UIButton!{
        didSet{
            setupClinicButton.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var termsLabel : UILabel!{
        didSet{
            let attributedString = NSMutableAttributedString(string: termsText)
            attributedString.addAttribute(.font, value: UIFont(name:"Inter-SemiBold",size:14), range: NSRange(location: 58, length: 13))
            attributedString.addAttribute(.foregroundColor, value: UIColor(rgb: 0xED6E2E), range: NSRange(location: 58, length: 13))
            termsLabel.attributedText = attributedString
            let tap = UITapGestureRecognizer(target: self, action: #selector(openPhoneCall))
            termsLabel.isUserInteractionEnabled = true
            termsLabel.addGestureRecognizer(tap)
        }
    }
    
    var termsText = "For any further questions, please feel free to call us on 1800 102 7526"
    var mobileNo = ""
    var prospectid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func didTapOnSetupClinicBtn(_ sender: UIButton){
        let vc = mdpStoryBoard.instantiateViewController(identifier: "SetupClinicVC") as SetupClinicVC
        vc.prospectedID = "\(prospectid)"
        vc.mobileNo = self.mobileNo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openPhoneCall(){
        if let url = NSURL(string: "tel://1800 102 7526"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
}
