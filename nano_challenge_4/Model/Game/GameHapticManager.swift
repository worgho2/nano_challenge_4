//
//  GameHapticManager.swift
//  nano_challenge_4
//
//  Created by otavio on 16/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class GameHapticManager {
    
    let impact: UIImpactFeedbackGenerator!
    let selection: UISelectionFeedbackGenerator!
    let notification:  UINotificationFeedbackGenerator!
    
    init() {
        self.impact = UIImpactFeedbackGenerator()
        self.selection = UISelectionFeedbackGenerator()
        self.notification = UINotificationFeedbackGenerator()
        
        self.prepare()
    }
    
    private func prepare() {
        self.impact.prepare()
        self.selection.prepare()
        self.notification.prepare()
    }

}
