//
//  Currency.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 30..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import Foundation

class Currency{
    enum Unit: String{
        case USD, KRW, JPY, EUR
        
        var flagImage: UIImage{
            switch(self){
            case .EUR:
                return #imageLiteral(resourceName: "flag_england")
            case .KRW:
                return #imageLiteral(resourceName: "flag_kor")
            case .JPY:
                return #imageLiteral(resourceName: "flag_japan")
            case .USD:
                return #imageLiteral(resourceName: "flag_usa")
            }
        }
        
        var character: Character{
            switch(self){
            case .EUR:
                return "€"
            case .KRW:
                return "₩"
            case .JPY:
                return "¥"
            case .USD:
                return "$"
            }
        }
    }
    var value: Int
    var unit: Unit
    
    init(value: Int, unit: Unit){
        self.value = value
        self.unit = unit
    }
}
