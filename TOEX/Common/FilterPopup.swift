//
//  FilterPopup.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
class FilterPopup: UIView {
    
    enum FilterType{
        case distance, price
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    var currencyUnit: Currency.Unit?
    
    var handleCancel: (()->Void)?{
        didSet{
            
        }
    }
    
    var minValue: Double {
        get{
            return rangeSlider.minimumValue
        }
        set{
            rangeSlider.minimumValue = newValue
            minLabel?.text = "\(Int(newValue))"
        }
    }
    
    var maxValue: Double {
        get{
            return rangeSlider.maximumValue
        }
        set{
            rangeSlider.maximumValue = newValue
            maxLabel?.text = "\(Int(newValue))"
        }
    }
    
    var lowerValue: Double{
        get{
            return rangeSlider.lowerValue
        }
        set{
            rangeSlider.lowerValue = newValue
            updateRangeDisplay()
        }
    }
    
    var upperValue: Double{
        get{
            return rangeSlider.upperValue
        }
        set{
            rangeSlider.upperValue = newValue
            updateRangeDisplay()
        }
    }
    
    private func updateRangeDisplay(){
        rangeLabel?.text = "\(Int(lowerValue))"
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        handleCancel?()
    }
    
    class func instanceFromNib() -> FilterPopup {
        return UINib(nibName: "FilterPopup", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! FilterPopup
    }
    
    func dismissWithAnimation(){
        self.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.2, y: 0.2)
        }, completion: { [self] (success) in
            self.removeFromSuperview()
            })
    }

    func animateAppearing(from anchorPoint: CGPoint){
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.layer.anchorPoint = anchorPoint
            self.transform = CGAffineTransform.identity
        })
    }

}
