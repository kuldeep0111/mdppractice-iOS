//
//  AnalyseVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 10/02/21.
//

import UIKit

class AnalyseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnWatch(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
}
