//
//  NewOfferViewController.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 30..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacePicker

class NewOfferViewController: UIViewController {

    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var addMapInfoButton: UIButton!
    
    @IBOutlet weak var item1: UIView!
    @IBOutlet weak var item1FlagView: UIImageView!
    @IBOutlet weak var item1NationLabel: UILabel!
    @IBOutlet weak var item1CurrencyLabel: UILabel!
    @IBOutlet weak var item1InputBox: UITextField!
    @IBOutlet weak var item1PriceLabel: UILabel!
    
    
    @IBOutlet weak var item2: UIView!
    @IBOutlet weak var item2FlagView: UIImageView!
    @IBOutlet weak var item2NationLabel: UILabel!
    @IBOutlet weak var item2CurrencyLabel: UILabel!
    @IBOutlet weak var item2InputBox: UITextField!
    @IBOutlet weak var item2PriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "TOEX"))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        item1InputBox.resignFirstResponder()
        item2InputBox.resignFirstResponder()
    }
    
    @IBAction func addMap(_ sender: UIButton) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        self.present(placePicker, animated: true, completion: nil)
    }
    

    @IBAction func swapOfferItems(_ sender: Any) {
    }
    
    private func displayMap(location: Location){
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longtitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: mapContainer.bounds, camera: camera)
        
        mapContainer.addSubview(mapView)
        let position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longtitude)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = mapView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewOfferViewController: GMSPlacePickerViewControllerDelegate{
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Create the next view controller we are going to display and present it.
        //        let nextScreen = PlaceDetailViewController(place: place)
        //        self.splitPaneViewController?.push(viewController: nextScreen, animated: false)
        //        self.mapViewController?.coordinate = place.coordinate
        
        // Dismiss the place picker.
        viewController.dismiss(animated: true, completion: nil)
        
        displayMap(location: Location(latitude: place.coordinate.latitude, longtitude: place.coordinate.longitude))
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
