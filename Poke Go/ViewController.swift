//
//  ViewController.swift
//  Poke Go
//
//  Created by Zach Butcher on 8/1/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapview: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapview.showsUserLocation = true
            manager.startUpdatingLocation()
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 1000, 1000)
            mapview.setRegion(region, animated: true)
        }
        else{
            manager.requestWhenInUseAuthorization()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        // called evertime the location is updated
        manager.stopUpdatingLocation()
    }
    
    @IBAction func centerLocationTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate {
            mapview.showsUserLocation = true
            let region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000)
            mapview.setRegion(region, animated: true)
        }

    }
}

