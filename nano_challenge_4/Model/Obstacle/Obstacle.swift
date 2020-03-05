//
//  Obstacle.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class Obstacle: GameObject {
    
    override func shouldDespawn() -> Bool {
        return self.node.position.y > self.scene.getBounds().height + 35
    }
    
    override func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * 100
        
        self.node.position.y += dY
    }
    
}
