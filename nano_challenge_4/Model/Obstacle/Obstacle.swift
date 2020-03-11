//
//  Obstacle.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Obstacle: GameObject {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
        self.node.zPosition = -1
    }
    
    //MARK: - Class Methods
    
    func onCollision(paintWith color: UIColor) {
        guard let node = self.node as? SKSpriteNode else { fatalError() }
        
        node.color = color
        node.physicsBody = nil
        node.run(.sequence(
            [
                .scale(to: 0.8, duration: 0.05),
                .scale(to: 1.0, duration: 0.05)
            ]
        ))
        node.run(.sequence(
            [
                .fadeAlpha(to: 0.5, duration: 0.05),
                .fadeAlpha(to: 1.0, duration: 0.05)
            ]
        ))
        
        self.scene?.impactFeedback.impactOccurred()
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.scene.gameSpeedManager.getCurrentSpeed()
        self.node.position.y += dY
    }
}
