//
//  Drop.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Drop: GameObject {
    
    init(scene: SKScene?) {
        let node = scene?.childNode(withName: "drop")! as! SKSpriteNode
        node.position = CGPoint(x: 0, y: 500)
        
        let image = UIImage(named: "drop")!.tint(tintColor: .black)
        let texture = SKTexture(image: image)
        
        node.texture = texture
        node.scale(to: CGSize(width: 35, height: 65))
        
        super.init(node: node, scene: scene)
        
        self.configurePhysics(on: self.node)
        
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        guard let node = self.node as? SKSpriteNode else { return }
        
        let body = SKPhysicsBody(texture: node.texture!, size: node.size)
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = ContactMask.drop.bitMask
        body.collisionBitMask = ContactMask.none.bitMask
        body.contactTestBitMask = ContactMask.obstacle.bitMask
        
        self.node.physicsBody = body
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameStart() {
        self.node.run(.move(to: CGPoint(x: 0, y: 300), duration: 0.4))
    }
    
    override func onGameOver() {
        self.node.run(.sequence(
            [
                .repeat(.sequence([.moveTo(x: 10, duration: 0.1), .moveTo(x: -10, duration: 0.1)]), count: 2),
                .moveTo(x: 0, duration: 0.1),
                .move(to: CGPoint(x: 0, y: 500), duration: 0.4)
            ]
        ))
    }
}
