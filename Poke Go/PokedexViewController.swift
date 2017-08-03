//
//  PokedexViewController.swift
//  Poke Go
//
//  Created by Zach Butcher on 8/2/17.
//  Copyright © 2017 Zach Butcher. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var dataaccess = DataAccess()
    var pokemonlist :[Pokemon] = []
    var caughtPokemon :[Pokemon] = []
    var uncaughtPokemon :[Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonlist = dataaccess.getPokemons()
        caughtPokemon = dataaccess.getCaughtPokemon()
        uncaughtPokemon = dataaccess.getUncaughtPokemon()
        
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tomapTapped(_ sender: Any) {
        dismiss(animated: true) { 
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return caughtPokemon.count
        }else {
            return uncaughtPokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0{
            cell.imageView?.image = UIImage(named: caughtPokemon[indexPath.row].imagename!)
            cell.textLabel!.text = caughtPokemon[indexPath.row].name
        }else{
            cell.imageView?.image = UIImage(named: uncaughtPokemon[indexPath.row].imagename!)
            cell.textLabel!.text = uncaughtPokemon[indexPath.row].name
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Caught"
        }else{
            return "Uncaught"
        }
    }
}
