//
//  ObstacleFactory.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class ObstacleFactory: SceneSupplicant {
    
    var scene: GameScene!
    var baseNode: SKNode!
    
    init(scene: GameScene?) {
        self.scene = scene
        self.baseNode = self.getBaseNode()
    }
    
    private func getBaseNode() -> SKNode {
        let node = self.scene.childNode(withName: "obstacle")!
        let body = SKPhysicsBody(rectangleOf: .init(width: 250, height: 70))
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = ContactMask.obstacle.bitMask
        body.collisionBitMask = ContactMask.none.bitMask
        body.contactTestBitMask = ContactMask.painter.bitMask | ContactMask.drop.bitMask
        
        node.physicsBody = body
        
        return node
    }
    
    private func getNode() -> SKNode {
        let node = self.baseNode.copy() as! SKNode
        
        node.position = CGPoint(x: 0, y: self.scene.getBounds().minY - 35)
        node.zPosition = 100
        
        return node
    }
    
    func getNewObstacle() -> Obstacle {
        let node = self.getNode()
        
        return Obstacle(node: node, scene: self.scene)
    }
}
