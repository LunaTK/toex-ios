//
//  MapsViewController.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 30..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
import GooglePlacePicker

class MapsViewController: UIViewController {
    // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func pickPlace(_ sender: UIButton) {

        // Create a place picker. Attempt to display it as a popover if we are on a device which
        // supports popovers.
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
//        placePicker.popoverPresentationController?.sourceView = pickAPlaceButton
//        placePicker.popoverPresentationController?.sourceRect = pickAPlaceButton.bounds
        
        // Display the place picker. This will call the delegate methods defined below when the user
        // has made a selection.
        self.present(placePicker, animated: true, completion: nil)
    }

}

extension MapsViewController : GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Create the next view controller we are going to display and present it.
//        let nextScreen = PlaceDetailViewController(place: place)
//        self.splitPaneViewController?.push(viewController: nextScreen, animated: false)
//        self.mapViewController?.coordinate = place.coordinate
        
        // Dismiss the place picker.
        viewController.dismiss(animated: true, completion: nil)
        
        print("place : \(place)")
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        // In your own app you should handle this better, but for the demo we are just going to log
        // a message.
        NSLog("An error occurred while picking a place: \(error)")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        NSLog("The place picker was canceled by the user")
        
        // Dismiss the place picker.
        viewController.dismiss(animated: true, completion: nil)
    }
}
