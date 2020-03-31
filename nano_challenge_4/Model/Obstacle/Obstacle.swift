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
    var gameColorManager: GameColorManager!
    
    init(node: SKNode?, scene: GameScene?, gameAudioManager: GameAudioManager, gameHapticManager: GameHapticManager, gameSpeedManager: GameSpeedManager, gameColorManager: GameColorManager) {
        super.init(node: node, scene: scene)
        
        self.gameAudioManager = gameAudioManager
        self.gameHapticManager = gameHapticManager
        self.gameSpeedManager = gameSpeedManager
        self.gameColorManager = gameColorManager
        
        self.node!.zPosition = -1
    }
    
    //MARK: - Class Methods
    
    func onCollision(onCorrectPainter: Bool, at: CGPoint) {
        guard let node = self.node as? SKShapeNode else { return }
        node.physicsBody = nil
        node.zPosition = -10
        
        
        
        if onCorrectPainter {
            
            let gradientNode = SKShapeNode(circleOfRadius: 2)
            gradientNode.position = at
            gradientNode.fillColor = gameColorManager.pallete.background
            
            if node.fillColor == gameColorManager.pallete.left {
                gradientNode.strokeColor = gameColorManager.pallete.right
            } else {
                 gradientNode.strokeColor = gameColorManager.pallete.left
            }

            let maskNode = SKShapeNode()
            maskNode.position = .zero
            maskNode.path = node.path
            maskNode.fillColor = .white
            maskNode.strokeColor = .white
        
            let cropNode = SKCropNode()
            cropNode.position = .zero
            cropNode.maskNode = maskNode
            cropNode.addChild(gradientNode)
            
            node.addChild(cropNode)
            
            gradientNode.run(.scale(to: 400, duration: 2))

            node.run(.sequence(
                [
                    .scale(to: 1.2, duration: 0.05),
                    .scale(to: 0.8, duration: 0.1),
                    .scale(to: 1.1, duration: 0.05),
                    .scale(to: 0.9, duration: 0.1),
                    .scale(to: 1.0, duration: 0.05),
                ]
            ))
            
            Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { (t) in
                node.strokeColor = self.gameColorManager.pallete.pattern
            }
            
            node.run(.fadeAlpha(to: 0.5, duration: 1))
            
            gameAudioManager.play(soundEffect: .correct_01)
            gameHapticManager.impact.impactOccurred()
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
            
            gameAudioManager.play(soundEffect: .incorrect)
            gameHapticManager.impact.impactOccurred()
        }
        
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.gameSpeedManager.currentSpeed
        self.node.position.y += dY
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameOver() {
        self.node.run(.fadeOut(withDuration: 0.5))
        self.node.physicsBody = nil
    }
}
