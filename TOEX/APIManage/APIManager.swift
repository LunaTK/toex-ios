//
//  APIManager.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import Foundation
import Alamofire

class APIManager{
    class func getOfferList(from location: Location, completion: @escaping (_ data: Dictionary<String, Any>)->Void){
        let url = "http://121.189.179.92:8000/getdistance/?lat=\(location.latitude)&lon=\(location.longtitude)"
        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                if let result = response.result.value as? Dictionary<String, Any> {
//                    print(result)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
