//
//  Comparable.swift
//  nano_challenge_4
//
//  Created by otavio on 02/04/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

extension Comparable {

    func clamped(to range: ClosedRange<Self>) -> Self {

        if self > range.upperBound {
            return range.upperBound
        } else if self < range.lowerBound {
            return range.lowerBound
        } else {
            return self
        }
    }
}
