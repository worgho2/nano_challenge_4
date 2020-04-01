//
//  PowerUp.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class PowerUp: GameObject {
    
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
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().maxY + max(self.node.frame.height,  self.node.frame.width)/2
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.gameSpeedManager.currentSpeed
        self.node.position.y += dY
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameOver() {
        self.node.run(.fadeOut(withDuration: 1))
        self.node.physicsBody = nil
    }
    
}
