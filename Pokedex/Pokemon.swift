//
//  Pokemon.swift
//  Pokedex
//
//  Created by Forrest Knight on 2/21/17.
//  Copyright © 2017 Forrest Knight. All rights reserved.
//

import Foundation

class Pokemon {
    
    //Properties
    private var _name: String!
    private var _pokedexId: Int!
    
    //Getters
    var name: String {
        
        return _name
        
    }
    
    var pokedexId: Int {
        
        return _pokedexId
        
    }
    
    //Initializer
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
    }
    
}
