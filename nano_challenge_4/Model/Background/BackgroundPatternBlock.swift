//
//  BackgroundPattern.swift
//  nano_challenge_4
//
//  Created by otavio on 12/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class BackgroundPatternBlock: GameObject {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
    }
    
    init(scene: GameScene?) {
        let node = SKNode()
        super.init(node: node, scene: scene)
        
        self.setupPatternBlock()
    }
    
    //MARK: - Class Methods
    
    private func setupPatternBlock() {
        let image = UIImage(named: "pattern")!.tint(tintColor: .black)
        let texture = SKTexture(image: image)
        let width: CGFloat = self.scene.getBounds().width/3
        let aspectRatio: CGFloat = 845/900
        let height: CGFloat = width * aspectRatio
        
        let baseNode = SKSpriteNode(texture: texture, size: CGSize(width: width, height: height))
        baseNode.position = CGPoint(x: 0, y: 0)
        baseNode.alpha = 0.15
        
        let leftNode = baseNode.copy() as! SKSpriteNode
        leftNode.position = CGPoint(x: self.scene.getBounds().minX + leftNode.frame.width/2, y: 0)
        
        let rightNode = baseNode.copy() as! SKSpriteNode
        rightNode.position = CGPoint(x: self.scene.getBounds().maxX - rightNode.frame.width/2, y: 0)
        
        self.node.addChild(baseNode)
        self.node.addChild(leftNode)
        self.node.addChild(rightNode)
    }
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().height + self.node.children.first!.frame.height
    }
    
    //MARK: - Updateable PROTOCOL
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * scene.gameManager.speed.currentSpeed * 0.9
        self.node.position.y += dY
    }
    
}
