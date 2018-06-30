//
//  OfferDetailViewController.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 30..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
import GoogleMaps

class OfferDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var provideLabel: UILabel!
    @IBOutlet weak var recieveLabel: UILabel!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var kakaotalkIDButton: UIButton!
    
    var offer: Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "TOEX"))
        // Do any additional setup after loading the view.
    }
    
    private func displayOffer(){
        guard offer != nil else {return}
        usernameLabel.text = offer!.offerer.username!
        provideLabel.text = "\(offer!.provide.value)\(offer!.provide.unit.character)"
        recieveLabel.text = "\(offer!.recieve.value)\(offer!.recieve.unit.character)"
        kakaotalkIDButton.titleLabel?.text = offer!.offerer.kakaoid!
        locationLabel.text = offer!.place
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupProfileImage()
        displayOffer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }

    private func setupProfileImage(){
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }

    private func setupMapView(){
        let location = offer!.location
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
