//
//  GenericNode.swift
//  GASpel
//
//  Created by Filip Flodén on 2018-12-18.
//  Copyright © 2018 Filip Flodén. All rights reserved.
//

import SpriteKit

struct CollisionBitmask{
    static let Player:UInt32 = 0x00
    static let Coin:UInt32 = 0x01
    static let Platform:UInt32 = 0x02
}

enum PlatformType:Int{
    case platform = 0
    case platformBreakable = 1
}

class GenericNode: SKNode {
    
    func collisionWithPlayer (player:SKNode) -> Bool {
        return false
    }
    
    func shouldRemoveNode (playerY:CGFloat) {
        if playerY > self.position.y + 280 {
            self.removeFromParent()
        }
    }
}
