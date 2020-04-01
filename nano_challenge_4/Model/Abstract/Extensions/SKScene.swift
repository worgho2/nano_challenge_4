//
//  SKScene.swift
//  nano_challenge_4
//
//  Created by otavio on 11/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

extension SKScene {
    
    func getBounds() -> CGRect {
        return CGRect(x: -self.size.width/2,
                      y: -self.size.height/2,
                      width: self.size.width,
                      height: self.size.height
        )
    }
    
}
