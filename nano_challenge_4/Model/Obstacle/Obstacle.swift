//
//  Obstacle.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Obstacle: GameObject {
    
    override init(node: SKNode?, scene: GameScene?) {
        super.init(node: node, scene: scene)
    }
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * 200
        
        self.node.position.y += dY
    }
    
}
