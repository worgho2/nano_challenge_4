//
//  PowerUpFactory.swift
//  nano_challenge_4
//
//  Created by otavio on 01/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class PowerUpFactory: SceneSupplicant {
    
    internal var scene: GameScene!
    
    private let colorChangerBaseNode: SKNode!
    
    init(scene: GameScene?) {
        self.scene = scene
        self.colorChangerBaseNode = ColorChanger(scene: scene).node
    }
    
    //MARK: - Class Methods

    private func getNode() -> SKNode {
        let node = self.colorChangerBaseNode.copy() as! SKNode

        node.position = CGPoint(x: 0, y: self.scene.getBounds().minY - node.frame.height/2)
        node.zPosition = 100
       
        return node
    }
    
    func getNewPowerUp() -> PowerUp {
        let node = self.getNode()
        
        return ColorChanger(node: node, scene: scene)
        
    }
}
