//
//  Offers.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import Foundation

class Offers{
    private var offers = [Offer]()
    private var generateCounter = 1
    
    var updateDelegate: (() -> Void)?
    
    var count: Int {
        return offers.count
    }
    
    subscript(index: Int) -> Offer? {
        get {
            guard index>=0 && index < offers.count else { return nil }
            return offers[index]
        }
    }
    
    init(){
        loadNextPage()
    }
    
    func loadNextPage(){
        print("load next page")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[self] in
            APIManager.getOfferList(from: Location(latitude: 127, longtitude: 64), completion: { (data) in
                if let dict = data["distance"] as? Dictionary<String, Any>{
                    dict.forEach({ (index, offerAny) in
                        if let offerDict = offerAny as? Dictionary<String, Any>{
                            offerDict.forEach({ (distance, offerItem) in
                                
                                let offer = Offer(distance: Double(distance)!, with: offerItem as! Dictionary<String, Any>)
                                self.offers.append(offer)
                                print("ff")
                                
                            })
                        }
                    })
                }
                self.updateDelegate?()
            })
        }
    }
}


