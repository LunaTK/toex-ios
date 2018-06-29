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
    class func testRequest(){
        
        Alamofire.request("http://121.189.179.92:8000/dealslist/", method: .get).responseJSON { response in
            let data = response.data
            let jsonstr = try! JSONSerialization.jsonObject(with: response.data!, options: [])
            print(jsonstr)
            
            if let data = response.data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
//                debugPrint(json)
            }
            
            
        }
    }
}
