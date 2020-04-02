//
//  BackgroundPatternFactory.swift
//  nano_challenge_4
//
//  Created by otavio on 12/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class BackgroundPatternBlockFactory: SceneSupplicant {
    
    var scene: GameScene!
    
    private var backgroundPatternBlockBaseNode: SKNode!
    
    init(scene: GameScene?) {
        self.scene = scene
        
        self.backgroundPatternBlockBaseNode = BackgroundPatternBlock(scene: scene).node
    }
    
    //MARK: - Class Methods
    
    private func getNode() -> SKNode {
        let node = self.backgroundPatternBlockBaseNode.copy() as! SKNode
        
        node.position = CGPoint(x: 0, y: self.scene.getBounds().minY - node.children.first!.frame.height/2)
        node.zPosition = -100

        return node
    }
    
    func getNewBackgroundPatternBlock() -> BackgroundPatternBlock {
        let node = self.getNode()
        
        return BackgroundPatternBlock(node: node, scene: self.scene)
    }
    
    func getInitialBackgroundPatternBlockPack() -> [BackgroundPatternBlock] {
        var nodes = [BackgroundPatternBlock]()
        
        let from = self.scene.getBounds().height - self.backgroundPatternBlockBaseNode.children.first!.frame.height/2
        
        let to = self.scene.getBounds().minY - self.backgroundPatternBlockBaseNode.children.first!.frame.height/2
        
        let by = -self.backgroundPatternBlockBaseNode.children.first!.frame.height
        
        for posY in stride(from: from, to: to, by: by) {
            let node = self.getNode()
            node.position.y = posY
            
            nodes.append(BackgroundPatternBlock(node: node, scene: self.scene))
        }
        
        
        return nodes
    }
}


