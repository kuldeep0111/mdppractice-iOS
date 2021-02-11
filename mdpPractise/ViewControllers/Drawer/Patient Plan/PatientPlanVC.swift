//
//  PatientPlanVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/02/21.
//

import UIKit

class PatientPlanVC: UIViewController, CAPSPageMenuDelegate {

    var controllerArray : [UIViewController] = []
    var pageMenu: CAPSPageMenu?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Patient Plan"
        PageMenu()
    }
    
    func PageMenu() {
            
            let profile = self.storyboard?.instantiateViewController(withIdentifier: "UpcomingAppoinmentsVC") as! UpcomingAppoinmentsVC
        profile.title = "UPCOMING APPOINTMENTS"
            
            
            
            let reviws = self.storyboard?.instantiateViewController(withIdentifier: "ViewHistoryVC") as! ViewHistoryVC
           reviws.title = "HISTORY"
            
          let reviws2 = self.storyboard?.instantiateViewController(withIdentifier: "DependentsVC") as! DependentsVC
        reviws2.title = "DEPENDENTS"
        
            self.controllerArray.append(profile)
            self.controllerArray.append(reviws)
            self.controllerArray.append(reviws2)
            
            // Customize menu (Optional)
            let parameters: [CAPSPageMenuOption] = [
                .scrollMenuBackgroundColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1.00)),
                .viewBackgroundColor(UIColor.white),
                .selectionIndicatorColor(UIColor(rgb: 0xE8E8E8)),
                .bottomMenuHairlineColor(UIColor.clear),
                .selectedMenuItemLabelColor(UIColor(rgb: 0x333333)),
                .unselectedMenuItemLabelColor(UIColor(rgb: 0x999999)),
                .menuItemFont(UIFont(name: "Inter-Regular", size: 14.0)!),
                .menuHeight(30.0),
                .menuItemWidth(CGFloat((self.view.frame.width - 50)/3)),
                .centerMenuItems(true),
                .menuItemSeparatorRoundEdges(true),
                .menuItemSeparatorColor(UIColor.blue),
                .enableHorizontalBounce(false)
            ]
            
            // Initialize scroll menu
            self.pageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: CGRect(x: 0.0, y: 83.0, width: self.view.frame.width, height:self.view.frame.height), pageMenuOptions: parameters)
                self.pageMenu?.delegate=self
            
            
            self.addChild(self.pageMenu!)
            self.view.addSubview(self.pageMenu!.view)
            
            self.pageMenu!.didMove(toParent: self)
            
        }

    
}
