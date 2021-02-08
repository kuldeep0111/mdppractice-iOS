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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnSetupClinicBtn(_ sender: UIButton){
        let story : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "SetupClinicVC") as! SetupClinicVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
