//
//  ColorChangerPowerUp.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class ColorChanger: PowerUp {
    
    override init(node: SKNode?, scene: GameScene?, gameAudioManager: GameAudioManager, gameHapticManager: GameHapticManager, gameSpeedManager: GameSpeedManager, gameColorManager: GameColorManager) {
        super.init(node: node, scene: scene, gameAudioManager: gameAudioManager, gameHapticManager: gameHapticManager, gameSpeedManager: gameSpeedManager, gameColorManager: gameColorManager)
    }
    
    
    init(scene: GameScene?, gameAudioManager: GameAudioManager, gameHapticManager: GameHapticManager, gameSpeedManager: GameSpeedManager, gameColorManager: GameColorManager) {
        
        let node = SKShapeNode(rectOf: CGSize(width: 50, height: 50), cornerRadius: 25)
        node.name = "colorChanger"
        
        super.init(node: node, scene: scene, gameAudioManager: gameAudioManager, gameHapticManager: gameHapticManager, gameSpeedManager: gameSpeedManager, gameColorManager: gameColorManager)
        
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(rectangleOf: .init(width: 50, height: 50))
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = ContactMask.powerUp.bitMask
        body.collisionBitMask = ContactMask.none.bitMask
        body.contactTestBitMask = ContactMask.painter.bitMask
        
        self.node.physicsBody = body
    }
    
}
