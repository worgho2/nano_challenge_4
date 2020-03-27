//
//  InterfaceReceiver.swift
//  nano_challenge_4
//
//  Created by otavio on 27/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

protocol InterfaceDelegate {
    func sendScore(score: Int, time: TimeInterval)
}
