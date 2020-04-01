//
//  ContactMask.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

enum ContactMask {
    case painter
    case obstacle
    case drop
    case powerUp
    case none
    
    var bitMask: UInt32 {
        switch self {
        case .painter:  return 0b1000
        case .obstacle: return 0b0100
        case .drop:     return 0b0010
        case .powerUp:  return 0b0001
        case .none:     return 0b0000
        }
    }
}
