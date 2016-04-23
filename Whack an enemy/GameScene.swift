//
//  GameScene.swift
//  Whack an enemy
//
//  Created by Alex Bleda on 23/04/16.
//  Copyright (c) 2016 Alex Bleda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
        
        var numRounds = 0
        
        var slots = [WhackSlot]()
        var newGameLabel: SKLabelNode!
        var gameScore: SKLabelNode!
    
        var nodesOver = [SKSpriteNode]()
    
        var score: Int = 0 {
            didSet{
                gameScore.text = "Score \(score)"
            }
        }
        
        var popupTime = 0.9
        
        override func didMoveToView(view: SKView) {
            /* Setup your scene here */
            let background = SKSpriteNode(imageNamed: "whackBackground4")
            background.position = CGPoint(x: 512, y: 384)
            background.blendMode = .Replace
            background.zPosition = -1
            addChild(background)
            
            gameScore = SKLabelNode(fontNamed: "Chalkduster")
            gameScore.text = "Score: 0"
            gameScore.position = CGPoint(x: 50, y: 100)
            gameScore.horizontalAlignmentMode = .Left
            gameScore.fontSize = 48
            addChild(gameScore)
            
            newGameLabel = SKLabelNode(fontNamed: "Chalkduster")
            newGameLabel.text = "NEW GAME"
            newGameLabel.position = CGPoint(x: 950, y: 100)
            newGameLabel.horizontalAlignmentMode = .Right
            newGameLabel.fontSize = 48
            newGameLabel.name = "restartGame"
            addChild(newGameLabel)
            
            /* Original Locations for Ipad
             for i in 0 ..< 5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 410)) }
             for i in 0 ..< 4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 320)) }
             for i in 0 ..< 5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 230)) }
             for i in 0 ..< 4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 140)) }
             */
            
            for i in 0 ..< 5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 440)) }
            for i in 0 ..< 4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 360)) }
            for i in 0 ..< 5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 280)) }
            for i in 0 ..< 4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 195)) }
            
            RunAfterDelay(1) { [unowned self] in
                self.createEnemy()
            }
            
        }
        
        func createSlotAt(pos: CGPoint) {
            let slot = WhackSlot()
            slot.configureAtPosition(pos)
            addChild(slot)
            slots.append(slot)
        }
        
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            /* Called when a touch begins */
            
            if let touch = touches.first {
                let location = touch.locationInNode(self)
                let nodes = nodesAtPoint(location)
                
                for node in nodes {
                    if node.name == "charFriend" {
                        let whackSlot = node.parent!.parent as! WhackSlot
                        if !whackSlot.visible { continue }
                        if whackSlot.isHit { continue }
                        
                        whackSlot.hit()
                        score -= 5
                        
                        runAction(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion:false))
                    }
                    else if node.name == "charEnemy" {
                        let whackSlot = node.parent!.parent as! WhackSlot
                        if !whackSlot.visible { continue }
                        if whackSlot.isHit { continue }
                        
                        whackSlot.charNode.xScale = 0.85
                        whackSlot.charNode.yScale = 0.85
                        
                        whackSlot.hit()
                        score += 1
                        
                        runAction(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
                    }
                    
                    else if node.name == "restartGame" {
                        newGame()
                    }
                }
            }
            
        }
        
        override func update(currentTime: CFTimeInterval) {
            /* Called before each frame is rendered */
        }
        
        func createEnemy() {
            
            numRounds += 1
            
            if numRounds >= 1000 {
                for slot in slots {
                    slot.hide()
                }
                
                let gameOver = SKSpriteNode(imageNamed: "gameOver")
                gameOver.position = CGPoint(x: 512, y: 384)
                gameOver.zPosition = 1
                addChild(gameOver)
                
                nodesOver.append(gameOver)
                
                return
            }
            
            popupTime *= 0.999
            
            slots = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(slots) as! [WhackSlot]
            slots[0].show(hideTime: popupTime)
            
            if RandomInt(min: 0, max: 12) > 4 { slots[1].show(hideTime: popupTime) }
            if RandomInt(min: 0, max: 12) > 8 { slots[2].show(hideTime: popupTime) }
            if RandomInt(min: 0, max: 12) > 10 { slots[3].show(hideTime: popupTime) }
            if RandomInt(min: 0, max: 12) > 11 { slots[4].show(hideTime: popupTime) }
            
            let minDelay = popupTime / 1.0
            let maxDelay = popupTime * 3
            
            RunAfterDelay(RandomDouble(min: minDelay, max: maxDelay)) { [unowned self] in
                self.createEnemy()
            }
            RunAfterDelay(1) { [unowned self] in
                self.createEnemy()
            }
        }
    
    func newGame() {
        popupTime = 0.9
        numRounds = 0
        score = 0
        createEnemy()
        removeChildrenInArray(nodesOver)
    }
}
