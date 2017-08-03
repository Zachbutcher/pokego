//
//  PokemonAnnotation.swift
//  Poke Go
//
//  Created by Zach Butcher on 8/3/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon = Pokemon()
    
    init(coordinate: CLLocationCoordinate2D, pokemon: Pokemon){
        self.coordinate = coordinate
        self.pokemon = pokemon
    }
    
    
}
