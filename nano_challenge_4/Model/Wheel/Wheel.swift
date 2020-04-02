//
//  Wheel.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Wheel: GameObject {
    
    enum RotationDirection: Int {
        case left
        case right
        case none
        
        var multiplier : CGFloat {
            switch self {
            case .left:
                return 1
            case .right:
                return -1
            case .none:
                return 0
            }
        }
    }
    
    private var isTouching: (left: Bool, right: Bool) = (false, false)
    
    init(scene: GameScene?) {
        
        let node = SKNode()
        node.position = .zero
        
        super.init(node: node, scene: scene)
        self.scene.addChild(node)
        
        self.setupPainters()
        self.setupWheelBackground()
    }
    
    //MARK: - Class Methods
    
    private func getRotationDirection() -> RotationDirection {
        
        if isTouching.right && isTouching.left {
            return .left
        }
        
        if isTouching.left {
            return .left
        }
        
        if isTouching.right {
            return .right
        }
        
        return .none
    }
    
    private func setupPainters() {
        let leftPainterNode = SKShapeNode(circleOfRadius: scene.getBounds().width * 0.06)
        leftPainterNode.name = GameObjectType.painter.name + "_left"
        leftPainterNode.position = CGPoint(x: -scene.getBounds().width/2 * 3/5 , y: 0)
        leftPainterNode.zPosition = 1
        leftPainterNode.fillColor = scene.gameManager.color.palette.left
        leftPainterNode.strokeColor = leftPainterNode.fillColor.withAlphaComponent(0.2)
        leftPainterNode.isAntialiased = true
        leftPainterNode.glowWidth = 3
        self.configurePhysics(on: leftPainterNode)
        
        let rightPainterNode = leftPainterNode.copy() as! SKShapeNode
        rightPainterNode.name = GameObjectType.painter.name + "_right"
        rightPainterNode.position = CGPoint(x: scene.getBounds().width/2 * 3/5 , y: 0)
        rightPainterNode.fillColor = scene.gameManager.color.palette.right
        rightPainterNode.strokeColor = rightPainterNode.fillColor.withAlphaComponent(0.2)
        self.configurePhysics(on: rightPainterNode)
        
        self.node.addChild(leftPainterNode)
        self.node.addChild(rightPainterNode)
    }
    
    private func setupWheelBackground() {
        let circleNode = SKShapeNode(circleOfRadius: scene.getBounds().width/2 * 3/5)
        
        circleNode.position = .zero
        circleNode.strokeColor = .white
        circleNode.lineWidth = 2
        circleNode.glowWidth = 0
        circleNode.zPosition = -1
        circleNode.fillColor = .clear
        circleNode.alpha = 1
        
        let shadowNode = circleNode.copy() as! SKShapeNode
        
        shadowNode.position = .zero
        shadowNode.strokeColor = .white
        shadowNode.lineWidth = 0.1
        shadowNode.glowWidth = 5
        shadowNode.zPosition = -2
        shadowNode.fillColor = .clear
        shadowNode.alpha = 0.3
        
        self.node.addChild(shadowNode)
        self.node.addChild(circleNode)
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(circleOfRadius: scene.getBounds().width * 0.06)
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = GameObjectType.painter.categoryBitMask
        body.collisionBitMask = GameObjectType.painter.collisionBitMask
        body.contactTestBitMask = GameObjectType.painter.contactTestBitMask
        
        node.physicsBody = body
    }
    
    //MARK: - TouchSensitive PROTOCOL
    
    override func touchDown(atPoint pos: CGPoint) {
        if pos.x > 0 {
            if !scene.gameManager.onboarding.hasAlreadyShowed(.second) && scene.gameManager.onboarding.hasAlreadyShowed(.first) { return }
            
            scene.gameManager.onboarding.wheelRotationRight = true
            
            self.isTouching.right = true
            self.isTouching.left = false
        } else {
            if !scene.gameManager.onboarding.hasAlreadyShowed(.first) { return }
            
            scene.gameManager.onboarding.wheelRotationLeft = true
            
            self.isTouching.left = true
            self.isTouching.right = false
        }
    }
    
    override func touchUp(atPoint pos: CGPoint) {
        if pos.x > 0 {
            self.isTouching.right = false
        } else {
            self.isTouching.left = false
        }
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let rotation = CGFloat(deltaTime) * 2 * CGFloat.pi * self.getRotationDirection().multiplier
        self.node.zRotation += rotation
    }
    
    //MARK: - TriggeredByGameState PROTOCOL
    
    override func onGameStart() {
        self.node.run(.move(to: CGPoint(x: 0, y: 180), duration: 0.4))
        self.node.run(.rotate(toAngle: .pi, duration: 0.4))
        self.isTouching = (false, false)
    }
    
    override func onGameOver() {
        self.node.run(.move(to: CGPoint(x: 0, y: 0), duration: 0.4))
        self.node.run(.rotate(toAngle: 0, duration: 0.4))
        self.isTouching = (false, false)
    }
    
    //MARK: - PowerUpDelegate
    
    override func onColorChanger() {
        guard let leftNode = self.node.children.first(where: { $0.name!.contains("left")}) as? SKShapeNode, let rightNode = self.node.children.first(where: { $0.name!.contains("right")}) as? SKShapeNode else { return }
        
        leftNode.run(.sequence(
            [
                .scale(to: 1.2, duration: 0.05),
                .scale(to: 0.8, duration: 0.1),
                .scale(to: 1.1, duration: 0.05),
                .scale(to: 0.9, duration: 0.1),
                .scale(to: 1.0, duration: 0.05),
            ]
        ))
        
        rightNode.run(.sequence(
            [
                .scale(to: 1.2, duration: 0.05),
                .scale(to: 0.8, duration: 0.1),
                .scale(to: 1.1, duration: 0.05),
                .scale(to: 0.9, duration: 0.1),
                .scale(to: 1.0, duration: 0.05),
            ]
        ))
        
        leftNode.fillColor = scene.gameManager.color.palette.left
        leftNode.strokeColor = scene.gameManager.color.palette.left
        
        rightNode.fillColor = scene.gameManager.color.palette.right
        rightNode.strokeColor = scene.gameManager.color.palette.right
    }

}
