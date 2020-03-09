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
        
        super.init(node: node, scene: scene)
        
        self.setupPainters()
        self.setupWheelBackground()
    }
    
    private func getRotationDirection() -> RotationDirection {
        return isTouching.right ? .right : (isTouching.left ? .left : .none)
    }
    
    private func setupPainters() {
        let leftPainterNode = SKShapeNode(circleOfRadius: 20)
        leftPainterNode.name = "leftPainter"
        leftPainterNode.position = CGPoint(x: -100, y: 0)
        leftPainterNode.strokeColor = .clear
        leftPainterNode.zPosition = 1
        leftPainterNode.fillColor = .red
        self.configurePhysics(on: leftPainterNode)
        
        let rightPainterNode = leftPainterNode.copy() as! SKShapeNode
        rightPainterNode.name = "rightPainter"
        rightPainterNode.position = CGPoint(x: 100, y: 0)
        rightPainterNode.fillColor = .blue
        self.configurePhysics(on: rightPainterNode)
        
        self.node.addChild(leftPainterNode)
        self.node.addChild(rightPainterNode)
    }
    
    
    private func setupWheelBackground() {
        let circleNode = SKShapeNode(circleOfRadius: 100)
        
        circleNode.position = .zero
        circleNode.strokeColor = .black
        circleNode.lineWidth = 0.1
        circleNode.glowWidth = 1.0
        circleNode.zPosition = -1
        circleNode.fillColor = .clear
        circleNode.alpha = 0.7
        
        self.node.addChild(circleNode)
    }
    
    //MARK: - PHYSICS OBJECT PROTOCOL
    
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
    
    //MARK: - TOUCH SENSITIVE PROTOCOL
    
    override func touchDown(atPoint pos: CGPoint) {
        if pos.x > 0 {
            self.isTouching.right = true
        } else {
            self.isTouching.left = true
        }
    }
    
    override func touchUp(atPoint pos: CGPoint) {
        if pos.x > 0 {
            self.isTouching.right = false
        } else {
            self.isTouching.left = false
        }
    }
    
    //MARK: - UPDATEABLE PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let rotation = CGFloat(deltaTime) * CGFloat.pi / 2 * self.getRotationDirection().multiplier
        self.node.zRotation += rotation
    }
}
