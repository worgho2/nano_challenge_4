////
////  BackgroundPattern.swift
////  nano_challenge_4
////
////  Created by otavio on 12/03/20.
////  Copyright © 2020 Raieiros Studio. All rights reserved.
////
//
//import SpriteKit
//
//class BackgroundPattern: GameObject {
//    
//    override init(node: SKNode?, scene: SKScene?) {
//        super.init(node: node, scene: scene)
//    }
//    
//    init(scene: SKScene?) {
//        let node = scene?.childNode(withName: "backgroundPattern")!
//        super.init(node: node, scene: scene)
//    }
//    
//    
//    //MARK: - Class Methods
//    
////    override func shouldDespawn() -> Bool {
////        return self.node.position.y > self.scene.getBounds().height + self.node.frame.height/2
////    }
//    
//    //MARK: - Updateable PROTOCOL
//    
//    override func update(_ deltaTime: TimeInterval) {
//        let dY = CGFloat(deltaTime) * self.scene.gameSpeedManager.getCurrentSpeed()/2
//        self.node.position.y += dY
//    }
//    
//}
