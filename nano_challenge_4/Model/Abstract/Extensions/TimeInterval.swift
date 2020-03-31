//
//  TimeInterval.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func asString() -> String {

        let time = Int(self)

        let seconds = time % 60
        let minutes = time / 60
        
//        let minutes = (time / 60) % 60
//        let hours = (time / 3600)

        return String(format: "%0.2d:%0.2d",minutes,seconds)

    }
}
