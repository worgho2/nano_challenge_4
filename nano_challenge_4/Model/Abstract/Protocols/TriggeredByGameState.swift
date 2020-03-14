//
//  TriggeredByGameState.swift
//  nano_challenge_4
//
//  Created by otavio on 10/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation
 
protocol TriggeredByGameState {
    func onGameStart()
    func onGamePause()
    func onGameContinue()
    func onGameOver()
}
