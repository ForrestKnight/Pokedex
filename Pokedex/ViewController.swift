//
//  ViewController.swift
//  Pokedex
//
//  Created by Forrest Knight on 2/21/17.
//  Copyright © 2017 Forrest Knight. All rights reserved.
//
//  There are so many comments because I'm learning.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()

    }
    
    //Get the audio ready
    func initAudio() {
        
        //Path to the music
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        
        //Path to pokemon.csv
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            //Use parser to pull out rows
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            //Get ID and name from each row
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                //Create Pokemon object called poke, then attach it to Pokemon array
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
                
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }
    
    //Only loads those that are showing on screen
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            //If in search mode, filter the pokemon, else, go along with normal list
            if inSearchMode {
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
                
            } else {
                
                poke = pokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
                
            }
            
            //Call configureCell and pass in poke data to set label and image
            cell.configureCell(pokemon: poke)
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
        
    }
    
    //Executes when cell is tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
            
        } else {
            
            poke = pokemon[indexPath.row]
            
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }
    
    //Sets number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokemon.count
            
        }
        
        return pokemon.count
        
    }
    
    //Sets number of sections in collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    //Define the size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }
    
    //Pause/Play Music
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true) //Keyboard goes away
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true) //Keyboard goes away
        
    }
    
    //When we type in the search bar, whatever is in here will be called
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true) //Keyboard goes away
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC" {
            
            if let detailsVC = segue.destination as? PokemonDetailVC {
                
                if let poke = sender as? Pokemon {
                    
                    detailsVC.pokemon = poke
                    
                }
            }
        }
    }


}

