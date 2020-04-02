//
//  GameColorPalette.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SpriteKit

struct Palette {
    let right: UIColor
    let left: UIColor
    let background: UIColor
}

class GameColorManager: PowerUpDelegate {
    
    static var avaliablePalettes: [Palette] = [
        Palette(right: #colorLiteral(red: 0, green: 0.7529411765, blue: 0.8980392157, alpha: 1), left: #colorLiteral(red: 0.9764705882, green: 0.1803921569, blue: 0.6509803922, alpha: 1), background: #colorLiteral(red: 0.1803921569, green: 0.1921568627, blue: 0.5725490196, alpha: 1)),
        Palette(right: #colorLiteral(red: 0.9764705882, green: 0.1803921569, blue: 0.6509803922, alpha: 1), left: #colorLiteral(red: 0.9960784314, green: 0.9137254902, blue: 0, alpha: 1), background: #colorLiteral(red: 0.7450980392, green: 0.1529411765, blue: 0.09411764706, alpha: 1)),
        Palette(right: #colorLiteral(red: 0, green: 0.7529411765, blue: 0.8980392157, alpha: 1), left: #colorLiteral(red: 0.9960784314, green: 0.9137254902, blue: 0, alpha: 1), background: #colorLiteral(red: 0.1568627451, green: 0.6039215686, blue: 0.2588235294, alpha: 1))
    ]
    
    static var currentIndex: Int {
        get {
            return UserDefaults.standard.object(forKey: "colorManager.currentIndex") as? Int ?? 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "colorManager.currentIndex")
        }
    }
    
    var palette: Palette {
        return GameColorManager.avaliablePalettes[GameColorManager.currentIndex]
    }
    
    //MARK: - Class Methods
    
    func getPalette() -> Palette {
        return GameColorManager.avaliablePalettes[GameColorManager.currentIndex]
    }
    
    func getNextPalette() -> Palette {
        let nextIndex = (GameColorManager.currentIndex + 1) % GameColorManager.avaliablePalettes.count
        return GameColorManager.avaliablePalettes[nextIndex]
    }
    
    //MARK: - PowerUpDelegate
    
    func onColorChanger() {
        let nextIndex = (GameColorManager.currentIndex + 1) % GameColorManager.avaliablePalettes.count
        GameColorManager.currentIndex = nextIndex
    }

}
