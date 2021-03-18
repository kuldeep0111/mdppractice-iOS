//
//  MediaManager.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 17/03/21.
//

import Foundation
import UIKit

class MediaManager: APIManager {
    
    override class var sharedInstance: MediaManager {
        struct Static {
            static let instance: MediaManager = MediaManager()
        }
        return Static.instance
    }
    
    func UploadImage(img: UIImage,mediaFormat: String?,completionHandler: ((Bool, _ user: Any?, _ error: NSError?)->())?) {
        let imageData:NSData = img.pngData()! as NSData
        let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
        print(strBase64)
        var params: JSONDictionary = [:]
        params["action"]    = "upload_media"
        params["ref_code"] = "PRV"
        params["ref_id"] = providerID
        params["mediatype"] = "image"
        params["mediaformat"] = mediaFormat
        params["mediadata"] = strBase64
        
        let _ =  makeRequest(apiURL(APIEndPoint.uploadImage), action: .post, params: params) { (successful, response, error) in
            
            if successful {
                print(response)
                completionHandler?(true, nil, error)
                return
            }
            completionHandler?(false, [], error)
        }
    }
}
