//
//  ContactMask.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

enum GameObjectType {
    case painter
    case obstacle
    case drop
    case powerUp
    case none
    
    var categoryBitMask: UInt32 {
        switch self {
        case .painter:  return 0b1000
        case .obstacle: return 0b0100
        case .drop:     return 0b0010
        case .powerUp:  return 0b0001
        case .none:     return 0b0000
        }
    }
    
    var collisionBitMask: UInt32 {
        switch self {
        case .painter:  return Self.none.categoryBitMask
        case .obstacle: return Self.none.categoryBitMask
        case .drop:     return Self.none.categoryBitMask
        case .powerUp:  return Self.none.categoryBitMask
        case .none:     return Self.none.categoryBitMask
        }
    }
    
    var contactTestBitMask: UInt32 {
        switch self {
        case .painter:  return Self.obstacle.categoryBitMask | Self.powerUp.collisionBitMask
        case .obstacle: return Self.painter.categoryBitMask | Self.drop.collisionBitMask
        case .drop:     return Self.obstacle.categoryBitMask
        case .powerUp:  return Self.painter.categoryBitMask
        case .none:     return Self.none.categoryBitMask
        }
    }
    
    var name: String {
        switch self {
        case .painter:  return "painter"
        case .obstacle: return "obstacle"
        case .drop:     return "drop"
        case .powerUp:  return "powerup"
        case .none:     return "none"
        }
    }
}
