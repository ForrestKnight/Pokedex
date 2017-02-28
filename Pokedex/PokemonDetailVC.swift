//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Forrest Knight on 2/28/17.
//  Copyright © 2017 Forrest Knight. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name

    }
    

}
