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
    var ProcedureList: [ProcedureDetail] = []
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
    
    
    func ProcedureList(treatmentID: Int,completionHandler: ((Bool, _ user: [ProcedureDetail], _ error: NSError?)->())?) {

        var params: JSONDictionary = [:]
        params["action"]    = "getprocedures"
        params["treatmentid"] = treatmentID
        params["providerid"] = providerID
        params["searchphrase"] = ""
        params["page"] = 0
        
        let _ =  makeRequest(apiURL(APIEndPoint.procedureList), action: .post, params: params) { (successful, response, error) in
                        
            if successful {
                self.ProcedureList.removeAll()
                if let array = response["proclist"].arrayObject {
                    for item in array {
                        self.ProcedureList.append(ProcedureDetail(item as! JSONDictionary))
                    }
                    completionHandler?(true, self.ProcedureList, error)
                }
                return
            }
            completionHandler?(false, [], error)
        }
    }
}

