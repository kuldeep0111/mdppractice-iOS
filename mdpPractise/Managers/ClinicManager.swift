//
//  ClinicManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 05/03/21.
//

import Foundation
import Sugar
import SwiftyJSON

class ClinicManager: APIManager {
    
    override class var sharedInstance: ClinicManager {
        struct Static {
            static let instance: ClinicManager = ClinicManager()
        }
        return Static.instance
    }
    
    var clinicArray : [ClinicListModel] = []
    
    func ClinicListList(completionHandler: ((Bool, _ user: [ClinicListModel], _ error: NSError?)->())?) {

        var params: JSONDictionary = [:]
        params["action"]    = "list_clinic"
        params["ref_code"] = "PRV"
        params["ref_id"] = providerID
    
        let _ =  makeRequest(apiURL(APIEndPoint.ClinicList), action: .post, params: params) { (successful, response, error) in
            
            if successful {
                self.clinicArray.removeAll()
                if let array = response["clinic_list"].arrayObject{
                       
                    for item in array {
                        self.clinicArray.append(ClinicListModel(item as! JSONDictionary))
                    }
                    print(array)
                }
                
                completionHandler?(true, self.clinicArray, error)
                return
            }
            completionHandler?(false, [], error)
        }
    }
    
    func getCity(completionHandler: ((Bool, _ user: [String], _ error: NSError?)->())?) {
        print(apiURL(APIEndPoint.City))

        let _ =  makeRequest(apiURL(APIEndPoint.City), action: .post, params: nil) { (successful, response, error) in
                
            var CityArray : [String] = []
            
            if successful {
                
                if let array = response.arrayObject{
                    
                    for item in array {
                        CityArray.append(item as! String)
                    }
                    
                }
                print(CityArray)
                completionHandler?(true, CityArray, error)
                return
            }
            completionHandler?(false, [], error)
        }
    }
    
    func getState(completionHandler: ((Bool, _ user: [String], _ error: NSError?)->())?) {
        print(apiURL(APIEndPoint.State))
                
        let _ =  makeRequest(apiURL(APIEndPoint.State), action: .post, params: nil) { (successful, response, error) in
                        
            if successful {
                
                var stateArray : [String] = []
                if let array = response.arrayObject{
                    
                    for item in array {
                        stateArray.append(item as! String)
                    }
                    
                }
                print(stateArray)

                
                completionHandler?(true, stateArray, error)
                return
            }
            completionHandler?(false, [], error)
        }
    }

    
    func AddNewClinic(prospectedID: String,mobileNo: String,name: String,address1: String,address2: String,city: String,state: String,pin: String,email: String, completionHandler: ((Bool, _ userType: Any?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]    = "new_clinic"
        params["ref_id"] = prospectedID
        params["name"] = name
        params["address1"] = address1
        params["address2"] = address2
        params["city"] = city
        params["st"] = state
        params["pin"] = pin
        params["email"] = email
        params["cell"] = mobileNo
        
       let user = UserDefaults.standard.integer(forKey: "userType")
        if(user == 3){
            params["ref_code"] = "PST"
        }else{
            params["ref_code"] = "PRV"
        }
        
        print(params)
        print(apiURL(APIEndPoint.UserLogin))
        let _ =  makeRequest(apiURL(APIEndPoint.NewClinic), action: .post, params: params) { (successful, response, error) in
            
            
            if successful {
                
                if let dict = response.dictionaryObject {
                    print(dict)
                }
                completionHandler?(true, nil, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }

    func ClinicDetail(clinicID: Int,completionHandler: ((Bool, _ user: ClinicDetailModel?, _ error: NSError?)->())?) {
        var params: JSONDictionary = [:]
        params["action"]    = "get_clinic"
        params["clinicid"] = clinicID
        
        let _ =  makeRequest(apiURL(APIEndPoint.ClinicDetail), action: .post, params: params) { (successful, response, error) in
                        
            if successful {
                
                var ClinicDetail : ClinicDetailModel?
                if let dict = response.dictionaryObject {
                    ClinicDetail = ClinicDetailModel(dict)
                }
                completionHandler?(true, ClinicDetail, error)
                return
            }
            completionHandler?(false, nil, error)
        }
    }

}
