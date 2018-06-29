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
            self.offers += Array(repeating: Offer(title: "title \(self.generateCounter)", description: "description"), count: 15)
            self.generateCounter += 1
            self.updateDelegate?()
        }
    }
}

class Offer{
    enum Kind {
        case buy
        case sell
    }
    
    var title: String
    var description: String
    
    init(title: String, description: String){
        self.title = title
        self.description = description
    }
}
