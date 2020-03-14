//
//  Obstacle.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit
import AudioToolbox

class Obstacle: GameObject {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
        self.node.zPosition = -1
    }
    
    //MARK: - Class Methods
    
    func onCollision(onCorrectPainter: Bool) {
        guard let node = self.node as? SKSpriteNode else { return }
        node.physicsBody = nil
        node.zPosition = 1000
        
        if onCorrectPainter {
            node.run(.sequence(
                [
                    .scale(to: 1.2, duration: 0.05),
                    .scale(to: 0.2, duration: 0.1)
                ]
            ))
            
            node.run(.colorize(with: .clear, colorBlendFactor: 1.0, duration: 0.15))
            
            self.scene?.impactFeedback.impactOccurred()
        } else {
            node.run(.colorize(with: .clear, colorBlendFactor: 1.0, duration: 1))
            node.run(.sequence(
                [
                    .move(by: CGVector(dx: 10, dy: 0), duration: 0.08),
                    .repeat(.sequence([ .move(by: CGVector(dx: -20, dy: 0), duration: 0.05), .move(by: CGVector(dx: 20, dy: 0), duration: 0.05)  ]), count: 2),
                    .move(by: CGVector(dx: -10, dy: 0), duration: 0.08)
                ]
            ))
            
            node.run(.sequence(
                [
                    .scale(to: 1.5, duration: 0.05),
                    .scale(to: 1.0, duration: 0.05)
                ]
            ))
            
            AudioServicesPlaySystemSound(SystemSoundID(1050))
        }
        
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.scene.gameSpeedManager.getCurrentSpeed()
        self.node.position.y += dY
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameOver() {
        self.node.run(.fadeOut(withDuration: 0.5))
        self.node.physicsBody = nil
    }
}
