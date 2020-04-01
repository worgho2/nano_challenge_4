//
//  ColorChangerPowerUp.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class ColorChanger: PowerUp {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
    }
    
    init(scene: GameScene?) {
        let node = SKShapeNode(rectOf: CGSize(width: 50, height: 50), cornerRadius: 25)
        node.name =  GameObjectType.powerUp.name
        
        super.init(node: node, scene: scene)
        
        self.configurePhysics(on: self.node)
    }
    
    //MARK: - Class Methods
    
    override func onCollision() {
        super.onCollision()
        
        //Desacoplar depois para um protocolo
        
        let index = GameColorManager.avaliablePalletes.firstIndex(where: {$0.background == scene.gameManager.color.pallete.background})
        
        scene.gameManager.color.pallete = GameColorManager.avaliablePalletes[(index! + 1) % 3]
        
        scene.run(.colorize(with: scene.gameManager.color.pallete.background, colorBlendFactor: 1, duration: 1))
        
        guard let leftNode = scene.wheel.node.children.first(where: { $0.name!.contains("left")}) as? SKShapeNode else { return }
        guard let rightNode = scene.wheel.node.children.first(where: { $0.name!.contains("right")}) as? SKShapeNode else { return }
        
        leftNode.fillColor = scene.gameManager.color.pallete.left
        leftNode.strokeColor = scene.gameManager.color.pallete.left
        
        rightNode.fillColor = scene.gameManager.color.pallete.right
        rightNode.strokeColor = scene.gameManager.color.pallete.right
        
        
        scene.obstacleSpawner.obstacles.forEach {
            $0.node.removeFromParent()
        }
        scene.obstacleSpawner.obstacles = []
    
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(rectangleOf: .init(width: 50, height: 50))
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = GameObjectType.powerUp.categoryBitMask
        body.collisionBitMask = GameObjectType.powerUp.collisionBitMask
        body.contactTestBitMask = GameObjectType.powerUp.contactTestBitMask
        
        self.node.physicsBody = body
    }
    
}
