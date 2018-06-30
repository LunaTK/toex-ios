//
//  Offer.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 30..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import Foundation

class Offer{
    var provide: Currency
    var recieve: Currency
    var location: Location
    var offerer: UserInfo
    var distance: Double
    var place: String
    
    init(offerer: UserInfo, provide: Currency, recieve: Currency, location: Location, distance: Double, place: String = "Unknown Place"){
        self.offerer = offerer
        self.provide = provide
        self.recieve = recieve
        self.location = location
        self.distance = distance
        self.place = place
    }
    convenience init(distance: Double, with dict: Dictionary<String, Any>){
        let userInfo = UserInfo(with: dict["user"] as! Dictionary<String, Any>)
//        let provideCurrency = Currency(value: dict["buyprice"] as! Int, unit: Currency.Unit(rawValue: dict["buyunit"] as! String)!)
//        let recieveCurrency = Currency(value: dict["sellprice"] as! Int, unit: Currency.Unit(rawValue: dict["sellunit"] as! String )!)
        let provideCurrency = Currency(value: 1242, unit: .JPY)
        let recieveCurrency = Currency(value: 9999, unit: .KRW)
        let location = Location(latitude: Double(dict["latitude"] as! String)!, longtitude: Double(dict["longtitude"] as! String)!)
        let place = dict["place"] as! String
        self.init(offerer: userInfo, provide: provideCurrency, recieve: recieveCurrency, location: location, distance: distance, place: place)
    }
}
