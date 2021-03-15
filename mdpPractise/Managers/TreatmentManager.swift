//
//  TreatmentManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 15/03/21.
//

import Foundation

class TreatmentManager: APIManager {
    
    override class var sharedInstance: TreatmentManager {
        struct Static {
            static let instance: TreatmentManager = TreatmentManager()
        }
        return Static.instance
    }
    
    var TreatmentList : [TreatmentDetails] = []
    
    func TreatmentList(completionHandler: ((Bool, _ user: TreatmentModel?, _ error: NSError?)->())?) {

        var params: JSONDictionary = [:]
        params["action"]    = "gettreatments"
        params["providerid"] = 1011
        params["clinicid"] = 5
        params["memberid"] = 13916
        params["patientid"] = 13916
    
        let _ =  makeRequest(apiURL(APIEndPoint.TreatmentList), action: .post, params: params) { (successful, response, error) in
            
            if successful {
              self.TreatmentList.removeAll()
                if let dict = response.dictionaryObject {
                    print(dict)
                    let data : TreatmentModel = TreatmentModel(dict)
                    
                    print(data.next)
                    
                    
                    completionHandler?(true, data, error)
                }
                return
            }
            completionHandler?(false, nil, error)
        }
    }
    
    func TreatmentDetail(treatmentID: Int,completionHandler: ((Bool, _ user: TreatmentInfoModel?, _ error: NSError?)->())?) {

        var params: JSONDictionary = [:]
        params["action"]    = "gettreatment"
        params["treatmentid"] = treatmentID
    
        let _ =  makeRequest(apiURL(APIEndPoint.TreatmentList), action: .post, params: params) { (successful, response, error) in
            
            if successful {
                if let dict = response.dictionaryObject {
                    print(dict)
                    let data : TreatmentInfoModel = TreatmentInfoModel(dict)
                    completionHandler?(true, data, error)
                }
                return
            }
            completionHandler?(false, nil, error)
        }
    }
}

