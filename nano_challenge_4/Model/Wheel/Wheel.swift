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
        let node = scene?.childNode(withName: "wheelNode")!
        node?.position = CGPoint(x: 0, y: 0)
        super.init(node: node, scene: scene)
        
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
        let leftPainterNode = SKShapeNode(circleOfRadius: 20)
        leftPainterNode.name = "leftPainter"
        leftPainterNode.position = CGPoint(x: -95, y: 0)
        leftPainterNode.strokeColor = .clear
        leftPainterNode.zPosition = 1
        leftPainterNode.fillColor = self.scene.gameColorPalette!.leftColor
        self.configurePhysics(on: leftPainterNode)
        
        let rightPainterNode = leftPainterNode.copy() as! SKShapeNode
        rightPainterNode.name = "rightPainter"
        rightPainterNode.position = CGPoint(x: 95, y: 0)
        rightPainterNode.fillColor = self.scene.gameColorPalette!.rightColor
        self.configurePhysics(on: rightPainterNode)
        
        self.node.addChild(leftPainterNode)
        self.node.addChild(rightPainterNode)
    }
    
    private func setupWheelBackground() {
        let circleNode = SKShapeNode(circleOfRadius: 95)
        
        circleNode.position = .zero
        circleNode.strokeColor = .black
        circleNode.lineWidth = 0.1
        circleNode.glowWidth = 1.0
        circleNode.zPosition = -1
        circleNode.fillColor = .clear
        circleNode.alpha = 0.7
        
        self.node.addChild(circleNode)
    }
    
    //MARK: - PhysicsObject PROTOCOL
    
    override func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(circleOfRadius: 20)
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = ContactMask.painter.bitMask
        body.collisionBitMask = ContactMask.none.bitMask
        body.contactTestBitMask = ContactMask.obstacle.bitMask
        
        node.physicsBody = body
    }
    
    //MARK: - TouchSensitive PROTOCOL
    
    override func touchDown(atPoint pos: CGPoint) {
        if pos.x > 0 {
            self.isTouching.right = true
            self.isTouching.left = false
        } else {
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
        self.node.run(.move(to: CGPoint(x: 0, y: 140), duration: 0.4))
        self.node.run(.rotate(byAngle: 2*CGFloat.pi, duration: 0.4))
    }
    
    override func onGameOver() {
        self.node.run(.move(to: CGPoint(x: 0, y: 0), duration: 0.4))
        self.node.run(.rotate(toAngle: 0, duration: 0.4))
    }
}
