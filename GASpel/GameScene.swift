//
//  GameScene.swift
//  GASpel
//
//  Created by Filip Flodén on 2018-12-18.
//  Copyright © 2018 Filip Flodén. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background:SKNode!
    var midground:SKNode!
    var foreground:SKNode!
    
    var hud:SKNode!
    
    var player:SKNode!
    
    var scaleFactor:CGFloat!
    
    var startBtn = SKSpriteNode(imageNamed: "start")
    var coinCurrency = SKSpriteNode(imageNamed: "coin")
    
    var endOfGamePosition = 0
    
    let motionManager = CMMotionManager()
    
    var xAcc:CGFloat = 0.0
    
    var scoreLabel:SKLabelNode!
    var coins:SKLabelNode!
    
    var imageView:UIImageView!
    
    var playersMaxY:Int!
    
    var gameOver = false
    
    var currentMaxY:Int!
    
    var lastPlatformPos:Int = 70
    var lastCoinPos:Int = 680
    
    var number:Int!
    
    var newFirst:Int = 1
    let newLast:Int = 100
    
    var difficulty:Int = 70
    
//    var newPlatforms:Int = 7500
    var platformCounter:Int = 0
    var platformType:PlatformType = PlatformType.platform
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(size:CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        currentMaxY = 80
        GameHandler.sharedInstance.score = 0
        gameOver = false
        
        hud = SKNode()
        addChild(hud)
        
        scaleFactor = self.size.width / 320
        
        background = createBackground()
        addChild(background)
        
        foreground = SKNode()
        addChild(foreground)
        
        scoreLabel = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width - 24, y: self.size.height - 117)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.text = "0"
        addChild(scoreLabel)

        coinCurrency.position = CGPoint(x: 26, y: self.size.height - 106)
        coinCurrency.size = CGSize(width: 30, height: 30)
        addChild(coinCurrency)
        
        coins = SKLabelNode(fontNamed: "BodoniSvtyTwoITCTT-Book")
        coins.fontSize = 30
        coins.fontColor = SKColor.white
        coins.position = CGPoint(x: 46, y: self.size.height - 117)
        coins.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coins.text = "" + String(GameHandler.sharedInstance.coins)
        addChild(coins)
        
        startBtn.position = CGPoint(x: self.size.width / 2 + 15, y: self.size.height / 2)
        startBtn.size = CGSize(width: 340, height: 240)
        addChild(startBtn)
        
        let platform = createPlatformAtPosition(position: CGPoint(x: 160, y: 70), ofType: PlatformType.platform)
        foreground.addChild(platform)
        
        player = createPlayer()
        foreground.addChild(player)
    
        physicsWorld.gravity = CGVector(dx: 0, dy: -2) // Gravitationen av gubben i spelet
        physicsWorld.contactDelegate = self // Känner igen om två object med physicsBody kolliderar
        
        //  119-125 Gör så att spelarens x acceleration ändras när man lutar telefonen
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data{
                let acceleration = accelerometerData.acceleration
                self.xAcc = (CGFloat(acceleration.x) * 1.125 + (self.xAcc * 0.375))
            }
        }
    }
    
    func createPlatforms(){
        var first:Int = 1
        let last:Int = 6
        
        while first < last {
            number = Int.random(in: 30...284)  // Slumpmässigt nummer vi använder för x positionen av plattformarna
            lastPlatformPos += difficulty
            lastCoinPos += 700
            platformCounter += 1
            
            // 139-147 Ökar y distansen mellan blocken så att spelet blir svårare
            if platformCounter < 20 {
                difficulty = 68
            }else if platformCounter < 30 {
                difficulty = 136
            }else if platformCounter < 37 {
                difficulty = 226
            }else if platformCounter < 50 {
                platformType = PlatformType.platformBreakable
            }
            
            // 150-151 Skapar en plattform genom att kalla funktionen createPlatformAtPosition och använder värdena som ändras varje gång en plattform skapas
            let platformRandom = createPlatformAtPosition(position: CGPoint(x: number, y: Int(lastPlatformPos)), ofType: platformType)
            foreground.addChild(platformRandom)
            
            // 154-155 Samma som plattformen fast den gör det med mynten som placeras slumpmässigt utöver världen
            let coin = createCoinAtPosition(position: CGPoint(x: number, y: lastCoinPos), ofType: CoinType.Coin)
            foreground.addChild(coin)
            
            first += 1
        }
        lastPlatformPos += difficulty
        
        // 162-163 Skapar en trasig plattform som försvinner så fort man hoppar på den
        let platformBreakableRandom = createPlatformAtPosition(position: CGPoint(x: number, y: Int(lastPlatformPos)), ofType: PlatformType.platformBreakable)
        foreground.addChild(platformBreakableRandom)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var updateHUD = false
        
        var otherNode:SKNode!
        
        if contact.bodyA.node != player{
            otherNode = contact.bodyA.node
        } else{
            otherNode = contact.bodyB.node
        }
        
        updateHUD = (otherNode as! GenericNode).collisionWithPlayer(player: player)
        
        if updateHUD {
            coins.text = "" + String(GameHandler.sharedInstance.coins)

        }
    }
    
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: xAcc * 400, dy: player.physicsBody!.velocity.dy)
        
        // 189-193 Om spelaren åker ur skärmen på vardera sida visas den på motsatt sida den åkte ut ifrån
        if (player.position.x < -20){
            player.position = CGPoint(x: self.size.width + 20, y: player.position.y)
        }else if (player.position.x > self.size.width + 20){
            player.position = CGPoint(x: -20, y: player.position.y)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if player.physicsBody!.isDynamic {
            return
        }
        
        difficulty = 70
        
        while newFirst < newLast{
            createPlatforms()
            newFirst += 1
        }
        
        startBtn.removeFromParent()
        
        player.physicsBody?.isDynamic = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if gameOver {
            return
        }
    
        foreground.enumerateChildNodes(withName: "PLATFORMNODE") { (node, stop) in
            let platform = node as! PlatformNode
            platform.shouldRemoveNode(playerY: self.player.position.y)
        }
        foreground.enumerateChildNodes(withName: "COINNODE") { (node, stop) in
            let coin = node as! CoinNode
            coin.shouldRemoveNode(playerY: self.player.position.y)
            
        }
        
        // Gör så att sikten följer med spelaren istället för att gubben tillslut försvinner längst uppe
        if (player.position.y > 200){
            foreground.position = CGPoint(x: 0, y: -((player.position.y - 200)))
        }
        
        // 236-240 Håller koll på nuvarande poäng spelaren har
        if Int(player.position.y) > currentMaxY {
            GameHandler.sharedInstance.score += Int(player.position.y) - currentMaxY
            currentMaxY = Int(player.position.y)
            scoreLabel.text = "" + String(GameHandler.sharedInstance.score - 40)
        }
        
        
        // Detta var en test som inte var helt optimal så vi kommenterade ut den tills vi hittar en lösning
        
//        if Int(player.position.y) > newPlatforms {
//            newFirst = 1
//            while newFirst < newLast{
//                createPlatforms()
//                newFirst += 1
//            }
//            newPlatforms += 7500
//        }
        
        if Int(player.position.y) < currentMaxY - 800 {
            endGame()
        }
    }
    
    func endGame() {
        gameOver = true
        GameHandler.sharedInstance.saveGameStats()
        
        let transition = SKTransition.fade(withDuration: 0.5)
        let endGameScene = GameOver(size: self.size)
        self.view?.presentScene(endGameScene, transition: transition)
    }
}
