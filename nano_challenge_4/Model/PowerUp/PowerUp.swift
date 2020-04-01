//
//  PowerUp.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class PowerUp: GameObject {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
        
        self.node!.zPosition = -1
    }
    
    //MARK: - Class Methods
    
    func onCollision() {
        guard let node = self.node as? SKShapeNode else { return }
        node.physicsBody = nil
        node.zPosition = -10
        
        scene.gameManager.audio.play(soundEffect: .correct_02)
        scene.gameManager.haptic.impact.impactOccurred()
        
        node.run(.sequence(
            [
                .scale(to: 1.2, duration: 0.05),
                .scale(to: 0.8, duration: 0.1),
                .scale(to: 1.1, duration: 0.05),
                .scale(to: 0.9, duration: 0.1),
                .scale(to: 1.0, duration: 0.05),
            ]
        ))
        
        node.run(.fadeAlpha(to: 0, duration: 1))
    }
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().maxY + max(self.node.frame.height,  self.node.frame.width)/2
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * scene.gameManager.speed.currentSpeed
        self.node.position.y += dY
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameOver() {
        self.node.run(.fadeOut(withDuration: 1))
        self.node.physicsBody = nil
    }
    
}
