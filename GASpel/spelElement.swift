//
//  spelElement.swift
//  GASpel
//
//  Created by Filip Flodén on 2018-12-18.
//  Copyright © 2018 Filip Flodén. All rights reserved.
//

import SpriteKit

extension GameScene{
    
    func createBackground () -> SKNode {
        let backgroundNode = SKNode()
        
        let node = SKSpriteNode(imageNamed: "background")
        node.size = CGSize(width: self.size.width, height: self.size.height)
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.position = CGPoint(x: self.size.width / 2, y: 0)
        backgroundNode.addChild(node)
        
        return backgroundNode
    }
    
    func createPlayer () -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: self.size.width / 2, y: 120)
        
        let sprite = SKSpriteNode(imageNamed: "player")
        sprite.size = CGSize(width: 40, height: 55)
        playerNode.addChild(sprite)
        
        
        // 35-50 Bestämmer all standard fysik vår "gubbe" kommer ha när den skapas vilket utan tvekan var en av de svåraste och tuffaste utmanningar eftersom att det krävdes mycket sökande för att få en förståelse om vad allt gör och vad som behövs för våra behov
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        
        playerNode.physicsBody?.isDynamic = false
        playerNode.physicsBody?.allowsRotation = false
        
        playerNode.physicsBody?.restitution = 1
        playerNode.physicsBody?.friction = 0
        playerNode.physicsBody?.angularDamping = 0
        playerNode.physicsBody?.linearDamping = 0
        
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        
        playerNode.physicsBody?.categoryBitMask = CollisionBitmask.Player
        
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.contactTestBitMask = CollisionBitmask.Coin | CollisionBitmask.Platform
        
        return playerNode
    }
    
    func createPlatformAtPosition (position:CGPoint, ofType type:PlatformType) -> PlatformNode {
        let node = PlatformNode()
        let position = CGPoint(x: position.x * scaleFactor, y: position.y)
        node.position = position
        node.name = "PLATFORMNODE"
        node.platformType = type
        
        var sprite:SKSpriteNode
        
        if type == PlatformType.platform {
            sprite = SKSpriteNode(imageNamed: "platform")
        }else{
            sprite = SKSpriteNode(imageNamed: "platformBreakable")
        }
        node.addChild(sprite)
        
        // 72-75 Samma här fast för plattformarna vilket inte var riktigt lika svåra att förstå när man redan hade skapat spelaren
        node.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionBitmask.Platform
        node.physicsBody?.collisionBitMask = 0
        
        return node
    }
    
    func createCoinAtPosition (position:CGPoint, ofType type:CoinType) -> CoinNode {
        let node = CoinNode()
        let position = CGPoint(x: position.x * scaleFactor, y: position.y)
        node.position = position
        node.name = "COINNODE"
        node.coinType = type
        
        var sprite:SKSpriteNode
        
        sprite = SKSpriteNode(imageNamed: "coin")
        sprite.size = CGSize(width: 20, height: 20)
        node.addChild(sprite)
        
        // Samma som plattformen
        node.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionBitmask.Coin
        node.physicsBody?.contactTestBitMask = 0
        
        return node
    }
}
