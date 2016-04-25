//
//  pictureScene.swift
//  Whack an enemy
//
//  Created by Alex Bleda on 24/04/16.
//  Copyright © 2016 Alex Bleda. All rights reserved.
//

import UIKit
import SpriteKit

class pictureScene: SKScene {
    
    override func didMoveToView(view: SKView) {
     
        backgroundColor = UIColor.blueColor()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
          if let touch = touches.first {
            let nextScene = GameScene(size: self.size)
            nextScene.scaleMode = scaleMode
            let reveal = SKTransition.fadeWithDuration(1)
            self.view?.presentScene(nextScene, transition: reveal)
        }
        
    }


}
