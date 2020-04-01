//
//  SquareObstacle.swift
//  nano_challenge_4
//
//  Created by otavio on 06/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit
//import UIKit

class SquareObstacle: Obstacle {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
    }
    
    init(scene: GameScene?) {
        let node = SKShapeNode(rectOf: CGSize(width: 120, height: 120), cornerRadius: 30)
        node.name = GameObjectType.obstacle.name
        
        super.init(node: node, scene: scene)
        
        self.configurePhysics(on: self.node)
    }
    
    //MARK: - Class Methods
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().height + 100
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(rectangleOf: .init(width: 120, height: 120))
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = GameObjectType.obstacle.categoryBitMask
        body.collisionBitMask = GameObjectType.obstacle.collisionBitMask
        body.contactTestBitMask = GameObjectType.obstacle.contactTestBitMask
        
        self.node.physicsBody = body
    }
}
