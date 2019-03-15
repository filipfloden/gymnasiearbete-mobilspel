//
//  PlatformNode.swift
//  GASpel
//
//  Created by Filip Flodén on 2018-12-18.
//  Copyright © 2018 Filip Flodén. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class PlatformNode: GenericNode {
    
    var platformType:PlatformType!
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        // Om hastighetet på spelaren är negativ, alltså att spelaren rör sig neråt så kan spelaren komma i konakt med plattformen och får därefter en hastighets "boost" uppåt
        if (player.physicsBody?.velocity.dy)! < 0 {
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 375)

            if platformType == PlatformType.platformBreakable{
                self.removeFromParent()
            }
            
        }
        return false
    }
}
