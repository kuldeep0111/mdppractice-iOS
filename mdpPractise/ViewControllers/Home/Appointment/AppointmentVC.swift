//
//  AppointmentVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 08/02/21.
//

import UIKit

class AppointmentVC: UIViewController,CAPSPageMenuDelegate {

    var controllerArray : [UIViewController] = []
    var pageMenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of Appointments"
        PageMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.title = "Appointments"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    
    func PageMenu() {
            
            let profile = self.storyboard?.instantiateViewController(withIdentifier: "UpcomingApointmentList") as! UpcomingApointmentList
            profile.title = "Apcoming Appointments"
            
            
            
            let reviws = self.storyboard?.instantiateViewController(withIdentifier: "BookingRequestVC") as! BookingRequestVC
            reviws.title = "Booking Request"
            
            
            self.controllerArray.append(profile)
            self.controllerArray.append(reviws)
            
            
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
                .menuItemWidth(CGFloat((self.view.frame.width - 44)/2)),
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
