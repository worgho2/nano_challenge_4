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
        let image = UIImage(named: "drop")!.tint(tintColor: .black)
        let texture = SKTexture(image: image)
        let size = CGSize(width: 35, height: 65)
        
        let node = SKSpriteNode(texture: texture, size: size)
        node.position = CGPoint(x: 0, y: 500)
        node.name = GameObjectType.drop.name
        
        super.init(node: node, scene: scene)
        self.scene.addChild(node)
        
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
        body.categoryBitMask = GameObjectType.drop.categoryBitMask
        body.collisionBitMask = GameObjectType.drop.collisionBitMask
        body.contactTestBitMask = GameObjectType.drop.contactTestBitMask
        
        self.node.physicsBody = body
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameStart() {
        self.node.removeAllActions()
        self.node.run(.move(to: CGPoint(x: 0, y: self.scene.getBounds().maxY - self.node.frame.height - 20), duration: 0.4))
    }
    
    override func onGameOver() {
        self.node.removeAllActions()
        self.node.run(.sequence(
            [
                .repeat(.sequence([.moveTo(x: 10, duration: 0.05), .moveTo(x: -10, duration: 0.05)]), count: 2),
                .moveTo(x: 0, duration: 0.05),
                .move(to: CGPoint(x: 0, y: 500), duration: 0.4)
            ]
        ))
    }
}
