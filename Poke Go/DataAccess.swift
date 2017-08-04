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
    var caughtPokemon :[Pokemon] = []
    var uncaughtPokemon :[Pokemon] = []
    
    init(){
        initializePokemon()
        Pokemons = getPokemons()
        caughtPokemon = getCaughtPokemon()
        uncaughtPokemon = getUncaughtPokemon()
        
        
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
    }
    
    func initializePokemon(){
        
        if getPokemons().count == 0{
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
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        
    }
    
    func getCaughtPokemon() -> [Pokemon]{
        let request = Pokemon.fetchRequest() as NSFetchRequest <Pokemon>
        
        request.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
        
        do {
            let pokemons = try context.fetch(request) as [Pokemon]
            return pokemons
        }catch {
            
        }
        return []
    }
    
    func getUncaughtPokemon() -> [Pokemon]{
        let request = Pokemon.fetchRequest() as NSFetchRequest <Pokemon>
        
        request.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
        
        do {
            let pokemons = try context.fetch(request) as [Pokemon]
            return pokemons
        }catch {
            
        }
        return []
    }
    
    func delete(name: Pokemon){
        context.delete(name)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func save(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
