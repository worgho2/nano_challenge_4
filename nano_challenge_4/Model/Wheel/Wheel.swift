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
        
        self.node.children.forEach { self.configurePhysics(on: $0) }
    }
    
    func configurePhysics(on node: SKNode) {
        let body = SKPhysicsBody(rectangleOf: .init(width: 40, height: 40))
        
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        body.categoryBitMask = ContactMask.painter.bitMask
        body.collisionBitMask = ContactMask.none.bitMask
        body.contactTestBitMask = ContactMask.obstacle.bitMask
        
        node.physicsBody = body
    }
    
    private func getRotationDirection() -> RotationDirection {
        return isTouching.right ? .right : (isTouching.left ? .left : .none)
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
