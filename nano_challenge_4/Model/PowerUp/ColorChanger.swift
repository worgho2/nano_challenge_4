//
//  ColorChangerPowerUp.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class ColorChanger: PowerUp {
    
    var palette: Palette!
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
        
        palette = scene?.gameManager.color.getNextPalette()
        self.setupAppearance(on: self.node)
    }
    
    init(scene: GameScene?) {
        let node = SKShapeNode(circleOfRadius: scene!.getBounds().width * 0.06)
        node.name =  GameObjectType.powerUp.name
        node.fillColor = .clear
        node.strokeColor = .clear
        
        super.init(node: node, scene: scene)
        
        self.configurePhysics(on: self.node)
    }
    
    //MARK: - Class Methods
    
    override func onCollision() {
        super.onCollision()
        
        scene.onColorChanger()
    }
    
    private func setupAppearance(on node: SKNode) {
        
        let leftNode = SKShapeNode(circleOfRadius: scene.getBounds().width * 0.05)
        leftNode.position = CGPoint(x: -10, y: 0)
        leftNode.fillColor = palette.left
        leftNode.strokeColor = palette.left.darker(by: 30)
        leftNode.glowWidth = 2
        
        let rightNode = leftNode.copy() as! SKShapeNode
        rightNode.position = CGPoint(x: 10, y: 0)
        rightNode.fillColor = palette.right
        rightNode.strokeColor = palette.right.darker(by: 30)
        rightNode.glowWidth = 2
        
        let leftScaleAction = SKAction.repeatForever(.sequence([
            .scale(to: 1.2, duration: 0.4),
            .scale(to: 0.9, duration: 0.4)
        ]))
        
        let rightScaleAction = SKAction.repeatForever(.sequence([
            .scale(to: 0.9, duration: 0.4),
            .scale(to: 1.2, duration: 0.4)
        ]))
        
        leftNode.run(.repeatForever(.sequence([.fadeAlpha(to: 0.8, duration: 0.5), .fadeAlpha(to: 1, duration: 0.5)])))
        rightNode.run(.repeatForever(.sequence([.fadeAlpha(to: 1, duration: 0.5), .fadeAlpha(to: 0.8, duration: 0.5)])))
        
        leftNode.run(leftScaleAction)
        rightNode.run(rightScaleAction)
        
        
        node.addChild(leftNode)
        node.addChild(rightNode)
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
