//
//  SorryView.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit

class SorryView: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapOnConfirm(_ sender: UIButton!){
        
    }
}
