//
//  GameViewController.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameEventListener {
    
    var scene: SKScene?
    
    @IBOutlet weak var skView: SKView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    private func loadScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            scene.scaleMode = .aspectFill
            scene.vc = self
            self.scene = scene
            self.skView.presentScene(scene)
        }
    }
    
    func bindGameEventListener() {
        GameEvent.allCases.forEach { GameEventBinder.bind(self, to: $0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindGameEventListener()
        
        self.playButton.setTitle("Play", for: .normal)
        self.pauseButton.isHidden = true
        
        self.loadScene()
        self.scene?.isPaused = true
        
        self.skView.ignoresSiblingOrder = true
        self.skView.showsFPS = true
        self.skView.showsNodeCount = true
        self.skView.showsPhysics = true
    }
    
    @IBAction func onPlayButton(_ sender: Any) {
        GameEventBinder.center.post(name: GameEvent.gameStart.asNotificationName(), object: nil)
        self.playButton.isHidden = true
        self.pauseButton.isHidden = false
    }
    
    @IBAction func onPauseButton(_ sender: Any) {
        GameEventBinder.center.post(name: GameEvent.gamePause.asNotificationName(), object: nil)
        self.playButton.isHidden = false
        self.playButton.setTitle("Continue", for: .normal)
        self.pauseButton.isHidden = true
    }
    
    //MARK: - Game Event Listener
    
    func onGameStart() {
        self.scene?.isPaused = false
    }
    
    func onGamePause() {
        self.scene?.isPaused = true
    }
    
    func onGameOver() {
        self.loadScene()
        self.scene?.isPaused = true
        
        self.playButton.isHidden = false
        self.playButton.setTitle("Play", for: .normal)
        self.pauseButton.isHidden = true
    }
    
    
    //MARK: - View Setup
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

