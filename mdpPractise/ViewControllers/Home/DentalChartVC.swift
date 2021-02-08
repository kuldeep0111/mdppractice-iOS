//
//  DentalChartVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class DentalChartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
}
