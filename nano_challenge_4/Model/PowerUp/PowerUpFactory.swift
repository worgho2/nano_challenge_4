//
//  PowerUpFactory.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class PowerUpFactory: SceneSupplicant {
    
    private var gameAudioManager: GameAudioManager!
    private var gameHapticManager: GameHapticManager!
    private var gameSpeedManager: GameSpeedManager!
    private var gameColorManager: GameColorManager!
    
    internal var scene: GameScene!
    
    private let colorChangerBaseNode: SKNode!
    
    init(scene: GameScene?, gameAudioManager: GameAudioManager, gameHapticManager: GameHapticManager, gameSpeedManager: GameSpeedManager, gameColorManager: GameColorManager) {
        self.scene = scene
        
        self.gameAudioManager = gameAudioManager
        self.gameHapticManager = gameHapticManager
        self.gameSpeedManager = gameSpeedManager
        self.gameColorManager = gameColorManager
        
        self.colorChangerBaseNode = ColorChanger(scene: scene, gameAudioManager: gameAudioManager, gameHapticManager: gameHapticManager, gameSpeedManager: gameSpeedManager, gameColorManager: gameColorManager).node
    }
    
    //MARK: - Class Methods

    private func getNode() -> SKNode {
        let node = self.colorChangerBaseNode.copy() as! SKShapeNode
        
        node.fillColor = .black
        node.strokeColor = .white
        node.position = CGPoint(x: 0, y: self.scene.getBounds().minY - node.frame.height/2)
        node.zPosition = 100
        node.isAntialiased = true
        node.glowWidth = 5
       
        return node
    }
    
    func getNewPowerUp() -> PowerUp {
        
        guard let node = self.getNode() as? SKShapeNode else {
            fatalError()
        }
        
        return ColorChanger(node: node, scene: self.scene, gameAudioManager: self.gameAudioManager, gameHapticManager: self.gameHapticManager, gameSpeedManager: self.gameSpeedManager, gameColorManager: self.gameColorManager)
        
    }
}
