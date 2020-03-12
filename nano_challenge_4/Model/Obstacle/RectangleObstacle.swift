//
//  RectangleObstacle.swift
//  nano_challenge_4
//
//  Created by otavio on 06/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class RectangleObstacle: Obstacle {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
    }
    
    init(scene: GameScene?) {
        let node = scene?.childNode(withName: "rectangleObstacle")!
        super.init(node: node, scene: scene)
        self.configurePhysics(on: self.node)
    }
    
    //MARK: - Class Methods
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().height + 200
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(rectangleOf: .init(width: 250, height: 70))
        
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
