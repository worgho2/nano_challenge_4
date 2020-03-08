//
//  Drop.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Drop: GameObject {
    
    init(scene: GameScene?) {
        let node = scene?.childNode(withName: "drop")!
        super.init(node: node, scene: scene)
        
        self.configurePhysics(on: self.node)
    }
    
    override func configurePhysics(on node: SKNode) {
        return
        let body = SKPhysicsBody(rectangleOf: .init(width: 40, height: 40))
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = ContactMask.drop.bitMask
        body.collisionBitMask = ContactMask.none.bitMask
        body.contactTestBitMask = ContactMask.obstacle.bitMask
        
        self.node.physicsBody = body
    }
}
