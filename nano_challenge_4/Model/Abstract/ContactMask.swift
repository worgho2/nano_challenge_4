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
    case none
    
    var bitMask: UInt32 {
        switch self {
        case .painter:
            return 0b001
        case .obstacle:
            return 0b010
        case .drop:
            return 0b100
        case .none:
            return 0b000
        }
    }
}
