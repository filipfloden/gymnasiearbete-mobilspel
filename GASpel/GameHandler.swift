//
//  GameHandler.swift
//  GASpel
//
//  Created by Filip Flodén on 2019-03-04.
//  Copyright © 2019 Filip Flodén. All rights reserved.
//

import Foundation

class GameHandler {
    var score:Int!
    var highScore:Int!
    var coins:Int!
    
    class var sharedInstance:GameHandler {
        struct Singleton {
            static let instance = GameHandler()
        }
        return Singleton.instance
    }
    
    init() {
        score = 0
        highScore = 0
        coins = 0
        
        let userDefaults = UserDefaults.standard
        highScore = userDefaults.integer(forKey: "highScore")
        coins = userDefaults.integer(forKey: "coins")
    }
    
    // saveGameStats är vår funktion som sparar rekordet och mynten lokalt på telefon, detta är inte optimalt för större applikationer och bör bara användas för att spara mindre saker
    func saveGameStats() {
        highScore = max(score, highScore)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(highScore, forKey: "highScore")
        userDefaults.set(coins, forKey: "coins")
        userDefaults.synchronize()
    }
}
