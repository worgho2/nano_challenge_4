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
    var pattern: UIColor!
    var auxiliar: UIColor!
    
    init(generator: PaletteGenerator) {
        let basePalette: [UIColor] = generator.getTriad().map({$0.getUIColor()})
        
        self.pattern = #colorLiteral(red: 0.1411764706, green: 0.1490196078, blue: 0.4431372549, alpha: 1) //basePalette[0]
        self.leftColor = #colorLiteral(red: 0, green: 0.7529411765, blue: 0.8980392157, alpha: 1) //basePalette[1]
        self.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.1921568627, blue: 0.5725490196, alpha: 1) //basePalette[2]
        self.rightColor = #colorLiteral(red: 0.9764705882, green: 0.1803921569, blue: 0.6509803922, alpha: 1)  //basePalette[3]
        self.auxiliar = #colorLiteral(red: 0.7176470588, green: 0.7647058824, blue: 0.9529411765, alpha: 1) //basePalette[4]
    }
}
