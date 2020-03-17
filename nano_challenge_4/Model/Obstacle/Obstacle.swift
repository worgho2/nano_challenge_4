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
    
    var gameAudioManager: GameAudioManager!
    var gameHapticManager: GameHapticManager!
    var gameSpeedManager: GameSpeedManager!
    
    init(node: SKNode?, scene: SKScene?, gameAudioManager: GameAudioManager, gameHapticManager: GameHapticManager, gameSpeedManager: GameSpeedManager) {
        super.init(node: node, scene: scene)
        
        self.gameAudioManager = gameAudioManager
        self.gameHapticManager = gameHapticManager
        self.gameSpeedManager = gameSpeedManager
        self.node!.zPosition = -1
    }
    
    //MARK: - Class Methods
    
    func onCollision(onCorrectPainter: Bool) {
        guard let node = self.node as? SKShapeNode else { return }
        node.physicsBody = nil
        node.zPosition = 1000
        
        if onCorrectPainter {
            node.run(.sequence(
                [
                    .scale(to: 1.2, duration: 0.05),
                    .scale(to: 0.2, duration: 0.1)
                ]
            ))
            
            node.run(.fadeOut(withDuration: 0.15))
            
            self.gameAudioManager.play(soundEffect: .splashNew)
            self.gameHapticManager.impact.impactOccurred()
        } else {
            node.run(.fadeOut(withDuration: 1))
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
            
            self.gameAudioManager.play(soundEffect: .waterDrop4)
            self.gameHapticManager.impact.impactOccurred()
        }
        
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.gameSpeedManager.getCurrentSpeed()
        self.node.position.y += dY
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameOver() {
        self.node.run(.fadeOut(withDuration: 0.5))
        self.node.physicsBody = nil
    }
}
