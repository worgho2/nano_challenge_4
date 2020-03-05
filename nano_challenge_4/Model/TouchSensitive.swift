//
//  TouchSensitive.swift
//  nano_challenge_4
//
//  Created by otavio on 05/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

protocol TouchSensitive {
    func touchDown(atPoint pos: CGPoint)
    func touchUp(atPoint pos: CGPoint)
}
