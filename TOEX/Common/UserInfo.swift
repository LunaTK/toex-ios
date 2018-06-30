//
//  UserInfo.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 30..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import Foundation

class UserInfo{
    var username: String?
    var profileURL: URL?
    var kakaoid: String?
    
    init(username: String? = nil, profileURL: URL? = nil, kakaoid: String? = nil){
        self.username = username
        self.profileURL = profileURL
        self.kakaoid = kakaoid
    }
    
    convenience init(with dict: [String:Any]){
        let url = URL(fileURLWithPath: dict["kakao_profile"] as! String)
        self.init(username: dict["id"] as? String, profileURL: url, kakaoid: "kakao_id")
    }
}
