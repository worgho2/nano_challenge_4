//
//  UIColor.swift
//  nano_challenge_4
//
//  Created by otavio on 09/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

extension UIColor {

    func add(_ overlay: UIColor) -> UIColor {
        var bgR: CGFloat = 0
        var bgG: CGFloat = 0
        var bgB: CGFloat = 0
        var bgA: CGFloat = 0
        
        var fgR: CGFloat = 0
        var fgG: CGFloat = 0
        var fgB: CGFloat = 0
        var fgA: CGFloat = 0
        
        self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
        overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
        
        let r = fgA * fgR + (1 - fgA) * bgR
        let g = fgA * fgG + (1 - fgA) * bgG
        let b = fgA * fgB + (1 - fgA) * bgB
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    /**
     Create a lighter color
     */
    public func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }

    /**
     Create a darker color
     */
    public func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }

    /**
     Changing R, G, B values
     */

    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {

        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {

            let pFactor = (100.0 + percentage) / 100.0

            let newRed = (red*pFactor).clamped(to: 0.0 ... 1.0)
            let newGreen = (green*pFactor).clamped(to: 0.0 ... 1.0)
            let newBlue = (blue*pFactor).clamped(to: 0.0 ... 1.0)

            return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
        }

        return self
    }
}

func +(lhs: UIColor, rhs: UIColor) -> UIColor {
    return lhs.add(rhs)
}
