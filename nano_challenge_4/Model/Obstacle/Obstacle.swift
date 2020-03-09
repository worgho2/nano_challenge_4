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
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * 500
        
        self.node.position.y += dY
    }
    
    func onCollision(withPanterColor color: UIColor) {
        guard let node = self.node as? SKSpriteNode else { fatalError() }
        
        let color = self.scene.colorPalleteGenerator.baseHSV.withSaturation(saturation: 0.5).rotated(by: 0.54)
        node.color = color.getUIColor().withAlphaComponent(0.5)
        node.physicsBody = nil
        
        node.run(.scale(by: 2, duration: 0.1))
        
        node.run(.sequence(
            [
                .scale(to: 1.1, duration: 0.05),
                .scale(to: 1.0, duration: 0.05)
            ]
        ))
        

        
        self.scene?.impactFeedback.impactOccurred()
        
    }
    
}
