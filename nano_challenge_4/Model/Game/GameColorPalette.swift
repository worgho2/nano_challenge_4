//
//  GameColorPalette.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

class GameColorPalette {
    
    var leftColor: UIColor!
    var rightColor: UIColor!
    var backgroundColor: UIColor!
    
    init(generator: PaletteGenerator) {
        let basePalette: [UIColor] = generator.getTriad().map({$0.getUIColor()})
        
        self.leftColor = basePalette[1]
        self.rightColor = basePalette[3]
        self.backgroundColor = basePalette[2]
    }
}
