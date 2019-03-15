//
//  CoinNode.swift
//  GASpel
//
//  Created by Filip Flodén on 2018-12-18.
//  Copyright © 2018 Filip Flodén. All rights reserved.
//

import SpriteKit

enum CoinType:Int{
    case Coin = 0
}

class CoinNode: GenericNode {
    var coinType:CoinType?
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        // När spelaren kommer i kontakt med mynt för han en hastighets "boost"
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 500)
        
        // Man får 500 extra poäng och 5 mynt för varje mynt man tar i spelet
        GameHandler.sharedInstance.score += 500
        GameHandler.sharedInstance.coins += 5
        
        self.removeFromParent()
        
        return true
    }
}
