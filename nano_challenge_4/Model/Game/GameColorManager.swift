//
//  GameColorPalette.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

struct Pallete {
    let right: UIColor
    let left: UIColor
    let background: UIColor
    let pattern: UIColor
}

class GameColorManager {
    
    static var avaliablePalletes: [Pallete]!
    
    private(set) var pallete: Pallete!
    
    init() {
        GameColorManager.avaliablePalletes = [
            Pallete(right: #colorLiteral(red: 0, green: 0.7529411765, blue: 0.8980392157, alpha: 1), left: #colorLiteral(red: 0.9764705882, green: 0.1803921569, blue: 0.6509803922, alpha: 1), background: #colorLiteral(red: 0.1803921569, green: 0.1921568627, blue: 0.5725490196, alpha: 1), pattern: #colorLiteral(red: 0.1411764706, green: 0.1490196078, blue: 0.4431372549, alpha: 1)),
            Pallete(right: #colorLiteral(red: 0.9764705882, green: 0.1803921569, blue: 0.6509803922, alpha: 1), left: #colorLiteral(red: 0.9960784314, green: 0.9137254902, blue: 0, alpha: 1), background: #colorLiteral(red: 0.7450980392, green: 0.1529411765, blue: 0.09411764706, alpha: 1), pattern: #colorLiteral(red: 0.5715494752, green: 0.1176898256, blue: 0.07190097123, alpha: 1)),
            Pallete(right: #colorLiteral(red: 0, green: 0.7529411765, blue: 0.8980392157, alpha: 1), left: #colorLiteral(red: 0.9960784314, green: 0.9137254902, blue: 0, alpha: 1), background: #colorLiteral(red: 0.1568627451, green: 0.6039215686, blue: 0.2588235294, alpha: 1), pattern: #colorLiteral(red: 0.112753652, green: 0.4274393916, blue: 0.1803924143, alpha: 1))
        ]
        
        self.pallete = GameColorManager.avaliablePalletes[2]
    }
}
