//
//  RectangleObstacle.swift
//  nano_challenge_4
//
//  Created by otavio on 06/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class RectangleObstacle: Obstacle {
    
    override init(node: SKNode?, scene: SKScene?, gameAudioManager: GameAudioManager, gameHapticManager: GameHapticManager, gameSpeedManager: GameSpeedManager, gameColorManager: GameColorManager) {
        super.init(node: node, scene: scene, gameAudioManager: gameAudioManager, gameHapticManager: gameHapticManager, gameSpeedManager: gameSpeedManager, gameColorManager: gameColorManager)
    }
    
    init(scene: SKScene?, gameAudioManager: GameAudioManager, gameHapticManager: GameHapticManager, gameSpeedManager: GameSpeedManager, gameColorManager: GameColorManager) {
        let node = SKShapeNode(rectOf: CGSize(width: 300, height: 70), cornerRadius: 35)
        node.name = "ractangleObstacle"
        
        super.init(node: node, scene: scene, gameAudioManager: gameAudioManager, gameHapticManager: gameHapticManager, gameSpeedManager: gameSpeedManager, gameColorManager: gameColorManager)
        
        self.configurePhysics(on: self.node)
    }
    
    //MARK: - Class Methods
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().height + 400
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(rectangleOf: .init(width: 300, height: 70))
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = ContactMask.obstacle.bitMask
        body.collisionBitMask = ContactMask.none.bitMask
        body.contactTestBitMask = ContactMask.painter.bitMask | ContactMask.drop.bitMask
        
        self.node.physicsBody = body
    }
}
