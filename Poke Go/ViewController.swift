//
//  ViewController.swift
//  Poke Go
//
//  Created by Zach Butcher on 8/1/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapview: MKMapView!
    
    var manager = CLLocationManager()
    var pokemonlist :[Pokemon] = []
    var data = DataAccess()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapview.delegate = self
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        pokemonlist = data.getPokemons()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapview.showsUserLocation = true
            manager.startUpdatingLocation()
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 1000, 1000)
            mapview.setRegion(region, animated: true)
        }
        else{
            manager.requestWhenInUseAuthorization()
        }
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
            
            let randomMon = arc4random_uniform(UInt32(self.pokemonlist.count))
            let pokemon = PokemonAnnotation(coordinate: self.manager.location!.coordinate, pokemon: self.pokemonlist[Int(randomMon)])
            
            let rand1 = CLLocationDegrees(Double(arc4random_uniform(100))/10000)
            let rand2 = CLLocationDegrees(Double(arc4random_uniform(100))/10000)
            
            if arc4random_uniform(100) > 50{
                pokemon.coordinate.longitude = self.manager.location!.coordinate.longitude - rand1
            }else{
                pokemon.coordinate.longitude = self.manager.location!.coordinate.longitude + rand1
            }
            
            if arc4random_uniform(100) > 50{
                pokemon.coordinate.latitude = self.manager.location!.coordinate.latitude - rand1
            }else{
                pokemon.coordinate.latitude = self.manager.location!.coordinate.latitude + rand2
            }
            
            self.mapview.addAnnotation(pokemon)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func  mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation{
            annoView.image = UIImage(named: "player")
        }else{
            
            annoView.image = UIImage(named: (annotation as! PokemonAnnotation).pokemon.imagename!)
            
            annoView.frame.size.height = 30
            annoView.frame.size.width = 30
        }
        
        return annoView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // called evertime the location is updated
        manager.stopUpdatingLocation()
    }
    
    @IBAction func centerLocationTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate {
            mapview.showsUserLocation = true
            let region = MKCoordinateRegionMakeWithDistance(coord, 500, 500)
            mapview.setRegion(region, animated: true)
        }
    }
    
    
}

