//
//  ThanksPageVC.swift
//  mdppractice
//
//  Created by rahul on 28/01/21.
//

import UIKit

class ThanksPageVC: UIViewController {

    @IBOutlet weak var setupClinicButton : UIButton!{
        didSet{
            setupClinicButton.layer.cornerRadius = 25
        }
    }
    
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
}
