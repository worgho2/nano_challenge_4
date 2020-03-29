//
//  BackgroundPattern.swift
//  nano_challenge_4
//
//  Created by otavio on 12/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class BackgroundPattern: GameObject {
    
    var gameSpeedManager: GameSpeedManager!
    
    init(node: SKNode?, scene: SKScene?, gameSpeedManager: GameSpeedManager) {
        super.init(node: node, scene: scene)
        
        self.gameSpeedManager = gameSpeedManager
    }
    
    init(scene: SKScene?, gameSpeedManager: GameSpeedManager) {
        let node = SKSpriteNode(imageNamed: "pattern")
        node.color = .white
        node.alpha = 1.0
        node.position = .zero
        
        
        super.init(node: node, scene: scene)
        
        self.gameSpeedManager = gameSpeedManager
    }
    
    
    //MARK: - Class Methods
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().height + self.node.frame.height/2
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.gameSpeedManager.getCurrentSpeed()
        self.node.position.y += dY
    }
    
}
