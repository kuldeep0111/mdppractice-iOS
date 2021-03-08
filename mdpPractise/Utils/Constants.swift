//
//  Constants.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import Foundation
import UIKit

let mdpStoryBoard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let kAppDelegate         = UIApplication.shared.delegate as! SceneDelegate
let kDeviceUuid          =  UIDevice.current.identifierForVendor?.uuidString
let IS_IPHONE_4  = UIDevice.current.userInterfaceIdiom == .phone && screenHeight == 480
let IS_IPHONE_5  = UIDevice.current.userInterfaceIdiom == .phone && screenHeight == 568

var IS_IPHONE_X_OR_NOCH: Bool {
   if #available(iOS 11.0, tvOS 11.0, *) {
     return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
 }
    return false
}

public typealias JSONArray = [[String : Any]]
public typealias JSONDictionary = [String : Any]


var selectedClinic : ClinicListModel?

var providerID = UserDefaults.standard.string(forKey: "providerid")
