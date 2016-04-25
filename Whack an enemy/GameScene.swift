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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        myLabel.text = "Welcome to Whack an Enemy!"
        myLabel.fontColor = UIColor.blackColor()
        myLabel.fontSize = 55
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 550)
        
        self.addChild(myLabel)
        
         let background = SKSpriteNode(imageNamed: "forest_main")
         background.position = CGPoint(x: 512, y: 384)
         background.blendMode = .Replace
         background.zPosition = -1
         addChild(background)
        
        
        let playButton = SKLabelNode(fontNamed: "Zapfino")
        playButton.text = "Classic Mode"
        playButton.fontColor = UIColor.blackColor()
        playButton.fontSize = 45
        playButton.name = "playButton"
        playButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: 300)
        
        addChild(playButton)
        
        let chaosButton = SKLabelNode(fontNamed: "Zapfino")
        chaosButton.text = "Chaos Mode"
        chaosButton.fontColor = UIColor.blackColor()
        chaosButton.fontSize = 45
        chaosButton.name = "chaosButton"
        chaosButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: 200)
        
        addChild(chaosButton)
        
        let pictureButton = SKLabelNode(fontNamed: "Zapfino")
        pictureButton.text = "Add Enemy Picture"
        pictureButton.fontColor = UIColor.redColor()
        pictureButton.fontSize = 45
        pictureButton.name = "pictureButton"
        pictureButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: 450)
        
        addChild(pictureButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            
            for node in nodes {
                if node.name == "playButton" {
                    let nextScene = playScene(size: self.size)
                    nextScene.scaleMode = scaleMode
                    let reveal = SKTransition.fadeWithDuration(1)
                    self.view?.presentScene(nextScene, transition: reveal)
                }
                else if node.name == "chaosButton" {
                    let nextScene = chaosScene(size: self.size)
                    nextScene.scaleMode = scaleMode
                    let reveal = SKTransition.fadeWithDuration(1)
                    self.view?.presentScene(nextScene, transition: reveal)
                }
                else if node.name == "pictureButton" {
                    let nextScene = pictureScene(size: self.size)
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

}
