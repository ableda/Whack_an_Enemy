//
//  chaosScene.swift
//  Whack an enemy
//
//  Created by Alex Bleda on 24/04/16.
//  Copyright © 2016 Alex Bleda. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class chaosScene: SKScene {
    
    var numRounds = 0
    var slots = [WhackSlot]()
    var newGameLabel: SKLabelNode!
    var gameScore: SKLabelNode!
    
    var nodesOver = [SKSpriteNode]()
    var labelsOver = [SKLabelNode]()
    
    var score: Int = 0 {
        didSet{
            gameScore.text = "Score \(score)"
        }
    }
    
    var popupTime = 0.9
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "grass2")
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
        
        for i in 0 ..< 6 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 600)) }
        for i in 0 ..< 5 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 520)) }
        for i in 0 ..< 6 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 440)) }
        for i in 0 ..< 5 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 360)) }
        for i in 0 ..< 6 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 280)) }
        for i in 0 ..< 5 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 195)) }
        
        readyLabels()
        
        RunAfterDelay(4) { [unowned self] in
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
                
                else if node.name == "mainMenu" {
                    let nextScene = GameScene(size: self.size)
                    nextScene.scaleMode = scaleMode
                    let reveal = SKTransition.fadeWithDuration(1)
                    self.view?.presentScene(nextScene, transition: reveal)
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
            gameOver.position = CGPoint(x: 512, y: 484)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            nodesOver.append(gameOver)
            
            let mainMenu = SKSpriteNode(imageNamed: "houseW")
            mainMenu.position = CGPoint(x: 512, y: 384)
            mainMenu.zPosition = 1
            mainMenu.name = "mainMenu"
            addChild(mainMenu)
            
            nodesOver.append(mainMenu)
            
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
    
    func readyLabels() {
        let ready = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        ready.text = "Ready!"
        ready.fontColor = UIColor.whiteColor()
        ready.fontSize = 150
        ready.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        ready.zPosition = 1
        addChild(ready)
        labelsOver.append(ready)
        
        RunAfterDelay(1) {
            self.removeChildrenInArray(self.labelsOver)
            let set = SKLabelNode(fontNamed: "MarkerFelt-Wide")
            set.text = "Set!"
            set.fontColor = UIColor.whiteColor()
            set.fontSize = 150
            set.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            set.zPosition = 1
            self.addChild(set)
            self.labelsOver.append(set)
            
            RunAfterDelay(1) {
                self.removeChildrenInArray(self.labelsOver)
                let go = SKLabelNode(fontNamed: "MarkerFelt-Wide")
                go.text = "GO!"
                go.fontColor = UIColor.whiteColor()
                go.fontSize = 150
                go.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                go.zPosition = 1
                self.addChild(go)
                self.labelsOver.append(go)
                
                RunAfterDelay(1) {
                    self.removeChildrenInArray(self.labelsOver)
                }
            }
        }
    }
    
    func newGame() {
        popupTime = 0.9
        numRounds = 0
        score = 0
        readyLabels()
        removeChildrenInArray(nodesOver)
        RunAfterDelay(4) { [unowned self] in
            self.createEnemy()
        }
    }

}
