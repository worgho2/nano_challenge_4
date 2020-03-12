//
//  BackgroundPatternFactory.swift
//  nano_challenge_4
//
//  Created by otavio on 12/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class BackgroundPatternFactory: SceneSupplicant {
    
    var scene: GameScene!
    
    private var backgroundPatternBaseNode: SKNode!
    
    init(scene: GameScene?) {
        self.scene = scene
        self.backgroundPatternBaseNode = BackgroundPattern(scene: self.scene).node
    }
    
    //MARK: - Class Methods
    
    private func getNode() -> SKNode {
        let node = self.backgroundPatternBaseNode.copy() as! SKShapeNode
        let bounds = self.scene.getBounds()
        
        node.setScale(20.0)
        node.position = CGPoint(x: 0, y: 0) //bounds.minY - node.frame.size.height/2
        node.zPosition = 10
        node.alpha = 1
//        node.texture = SKTexture(image: UIImage(named: "background_pattern")!)
        node.fillColor = UIColor(patternImage: UIImage(named: "background_pattern")!)
        
        return node
    }
    
    func getNewBackgroundPattern() -> BackgroundPattern {
        print("[SPAWN BACKGROUND PATTERN]")
        
        let node = self.getNode()
        return BackgroundPattern(node: node, scene: self.scene)
    }
}


