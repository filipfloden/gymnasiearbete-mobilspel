//
//  GameOver.swift
//  GASpel
//
//  Created by Filip Flodén on 2019-03-05.
//  Copyright © 2019 Filip Flodén. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver: SKScene {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override init(size: CGSize) {
        super.init(size: size)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: self.size.width, height: self.size.height)
        background.anchorPoint = CGPoint(x: 0.5, y: 0)
        background.position = CGPoint(x: self.size.width / 2, y: 0)
        addChild(background)
        
        
        // Koden som är utkommenterad nedan var en snabb test på hur våran shop skulle se ut, men vi kom aldrig så långt i spelets utveckling
        
//        let shop = SKSpriteNode(imageNamed: "shopTest")
//        shop.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.23)
//        shop.size = CGSize(width: self.size.width * 0.93, height: 1400)
//        addChild(shop)
//
//        let buy = SKSpriteNode(imageNamed: "shopButton")
//        buy.position = CGPoint(x: self.size.width * 0.82, y: self.size.height * 0.56)
//        buy.size = CGSize(width: 165, height: 100)
//        addChild(buy)
//
//        let description = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
//        description.fontSize = 13
//        description.fontColor = SKColor.gray
//        description.position = CGPoint(x: self.size.width / 4, y: self.size.height * 0.58)
//        description.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
//        description.text = "Some dumbass description about some dumbass character"
//        addChild(description)
//
//        let subDescription = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
//        subDescription.fontSize = 10
//        subDescription.fontColor = SKColor.gray
//        subDescription.position = CGPoint(x: self.size.width / 4, y: self.size.height * 0.56)
//        subDescription.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
//        subDescription.text = "Designed by: Some dumbass designer"
//        addChild(subDescription)
        
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.position = CGPoint(x: self.size.width / 2 - 15, y: self.size.height - 185)
        coin.size = CGSize(width: 30, height: 30)
        addChild(coin)
        
        let coinLabel = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
        coinLabel.fontSize = 30
        coinLabel.fontColor = SKColor.white
        coinLabel.position = CGPoint(x: self.size.width / 2 + 10, y: self.size.height - 196)
        coinLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinLabel.text = "" + String(GameHandler.sharedInstance.coins)
        addChild(coinLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: 300)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreLabel.text = "Score: " + String(GameHandler.sharedInstance.score)
        addChild(scoreLabel)
        
        
        let highScoreLabel = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
        highScoreLabel.fontSize = 30
        
        
        // Kollar om poängen man nyss fick har blivit det nya rekordet och agerar utefter det
        if GameHandler.sharedInstance.score == GameHandler.sharedInstance.highScore {
            highScoreLabel.fontColor = SKColor.green
        }else{
            highScoreLabel.fontColor = SKColor.red
        }
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: 450)
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        // Kollar om poängen man nyss fick har blivit det nya rekordet och agerar utefter det
        if GameHandler.sharedInstance.score == GameHandler.sharedInstance.highScore {
            highScoreLabel.text = "New Highscore: " + String(GameHandler.sharedInstance.highScore)
        }else{
            highScoreLabel.text = "Highscore: " + String(GameHandler.sharedInstance.highScore)
        }
        addChild(highScoreLabel)
        
        
        let tryAgainLabel = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
        tryAgainLabel.fontSize = 22
        tryAgainLabel.fontColor = SKColor.white
        tryAgainLabel.position = CGPoint(x: self.size.width / 2, y: 50)
        tryAgainLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        tryAgainLabel.text = "Tap Anywhere To Play Again"
        addChild(tryAgainLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene, transition: transition)
    }
}
