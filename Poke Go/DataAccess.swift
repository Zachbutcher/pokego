//
//  DataAccess.swift
//  Poke Go
//
//  Created by Zach Butcher on 7/28/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataAccess {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var Pokemons :[Pokemon] = []
    
    init(){
        Pokemons = getPokemons()
    }
    
    func getPokemons() -> [Pokemon]{
        do {
            return try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        }catch{
            
        }
        return Pokemons
    }
    
    func refreshPokemons(){
        do {
            try Pokemons = context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        }catch{
            
        }
    }
    
    func addPokemon(imageName: String, PokemonName: String){
        
        let newPokemon = Pokemon(context: context)
        newPokemon.name = PokemonName
        newPokemon.imagename = imageName
        newPokemon.caught = false
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        print(Pokemons)
    }
    
    func initializePokemon(){
        addPokemon(imageName: "mew", PokemonName: "Mew")
        addPokemon(imageName: "meowth", PokemonName: "Meowth")
        addPokemon(imageName: "bullbasaur", PokemonName: "Bullbasaur")
        addPokemon(imageName: "squirtle", PokemonName: "Squirtle")
        addPokemon(imageName: "pikachu", PokemonName: "Pikachu")
        addPokemon(imageName: "dratini", PokemonName: "Dratini")
        addPokemon(imageName: "charmander", PokemonName: "Charmander")
        addPokemon(imageName: "pidgey", PokemonName: "Pidgey")
        addPokemon(imageName: "rattata", PokemonName: "Rattata")
        addPokemon(imageName: "abra", PokemonName: "Abra")
        addPokemon(imageName: "snorlax", PokemonName: "snorlax")
        addPokemon(imageName: "caterpie", PokemonName: "caterpie")
        
    }
    
    func delete(name: Pokemon){
        context.delete(name)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
}
