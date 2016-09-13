//
//  GameScene.swift
//  SpriteAccel
//
//  Created by Philip on 9/9/16.
//  Copyright (c) 2016 Philip. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    var airplane = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var destY:CGFloat = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        airplane = SKSpriteNode(imageNamed: "Airplane")
        airplane.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        self.addChild(airplane)
        
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                
                let currentX = self.airplane.position.x
                let currentY = self.airplane.position.y
                
                self.destX = currentX + CGFloat(data!.acceleration.x * 100)
                self.destY = currentY + CGFloat(data!.acceleration.y * 100)
                
            })
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let point = CGPoint(x: destX, y: destY)
        var action = SKAction.moveTo(point, duration: 0.02)
        self.airplane.runAction(action)
//        action = SKAction.moveToY(destY, duration: 1)
//        self.airplane.runAction(action)
    }
}
