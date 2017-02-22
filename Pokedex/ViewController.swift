//
//  ViewController.swift
//  Pokedex
//
//  Created by Forrest Knight on 2/21/17.
//  Copyright © 2017 Forrest Knight. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        parsePokemonCSV()
        initAudio()

    }
    
    //Get the audio ready
    func initAudio() {
        
        //Path to the music
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
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
            
            let poke = pokemon[indexPath.row]
            
            //Call configureCell and pass in poke data to set label and image
            cell.configureCell(pokemon: poke)
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
        
    }
    
    //Executes when cell is tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    //Sets number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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


}

