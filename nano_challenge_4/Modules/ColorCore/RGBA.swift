//
//  RGBA.swift
//  Color Palette
//
//  Created by Bruno Pastre on 04/06/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class RGB {
    
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(fromHSV hsv: HSV) {
        let h = hsv.hue!, s = hsv.saturation!, v = hsv.value!
        if s == 0{
            self.red = v
            self.green = v
            self.blue = v
        }
        
        let Hi = (h / 60).truncatingRemainder(dividingBy: 6)
        
        let f = (h / 60) - Hi
        let p = v * (1 - s)
        let q = v * (1 - (f * s))
        let t = v * (1 - (s * (1 - f)))

        switch Hi.rounded() {
        case 0:
            self.red = v
            self.green = t
            self.blue = p
        case 1:
            self.red = q
            self.green = v
            self.blue = p
        case 2:
            self.red = p
            self.green = v
            self.blue = t
        case 3:
            self.red = p
            self.green = q
            self.blue = v
        case 4:
            self.red = t
            self.green = p
            self.blue = v
        case 5:
            self.red = v
            self.green = p
            self.blue = q
        case 6:
            self.red = v
            self.green = t
            self.blue = p   
        default:
            self.red = 0
            self.green = 0
            self.blue = 0
        }
    }
    
    func getMax() -> CGFloat {
        if self.red >= self.green && self.red >= self.blue{
            return self.red
        }
        if self.green >= self.red && self.green >= self.blue {
            return self.green
        }
        
        return self.blue
    }
    
    func getMin() -> CGFloat {
        if self.red <= self.green && self.red <= self.blue{
            return self.red
        }
        if self.green <= self.red && self.green <= self.blue {
            return self.green
        }
        
        return self.blue
    }
    
    func unpack() -> (CGFloat, CGFloat, CGFloat) {
        return (self.red, self.green, self.blue)
    }
}

class RGBA: RGB {
    
    var alpha: CGFloat!
    
    internal init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat?) {
        super.init(red: red, green: green, blue: blue)
        self.alpha = alpha
    }
}




