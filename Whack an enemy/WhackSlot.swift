//
//  WhackSlot.swift
//  Whack an enemy
//
//  Created by Alex Bleda on 23/04/16.
//  Copyright © 2016 Alex Bleda. All rights reserved.
//

import SpriteKit
import UIKit


class WhackSlot: SKNode {
    
    var charNode: SKSpriteNode!
    
    var visible = false
    var isHit = false
    
    func configureAtPosition(pos: CGPoint) {
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 20)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        // Here is where will need to change the images to whack and to not whack
        charNode = SKSpriteNode(imageNamed: "Messi")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime hideTime: Double) {
        if visible { return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        charNode.runAction(SKAction.moveByX(0, y: 80, duration: 0.05))
        visible = true
        isHit = false
        
        if RandomInt(min:0, max: 2) == 0 {
            charNode.texture = SKTexture(imageNamed: "Messi")   // change image here too
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "ronaldo")  // evil picture
            charNode.name = "charEnemy"
        }
        
        RunAfterDelay(hideTime * 3.0) { [unowned self] in  // time it stays up before hiding again
            self.hide()
        }
    }
    
    func hide() {
        if !visible { return }
        
        charNode.runAction(SKAction.moveByX(0, y: -80, duration: 0.05))
        visible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.waitForDuration(0.25)
        let hide = SKAction.moveByX(0, y: -80, duration: 0.5)
        let notVisible = SKAction.runBlock { [unowned self] in self.visible = false }
        charNode.runAction(SKAction.sequence([delay, hide, notVisible]))
        
    }

}
