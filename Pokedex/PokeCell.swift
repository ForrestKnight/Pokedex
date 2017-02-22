//
//  PokeCell.swift
//  Pokedex
//
//  Created by Forrest Knight on 2/21/17.
//  Copyright © 2017 Forrest Knight. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //Round the corners of the cell
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    //Update Cell When Called
    func configureCell(pokemon: Pokemon) {
        
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
    }
    
}
