//
//  GameViewController.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: SKScene?
    
    @IBOutlet weak var skView: SKView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    private func loadScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            scene.scaleMode = .aspectFill
            scene.vc = self
            
            self.scene = scene
            
            skView.presentScene(scene)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.setTitle("Play", for: .normal)
        pauseButton.isHidden = true
        
        loadScene()
        
        scene?.isPaused = true
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = false
    }
    
    @IBAction func onPlayButton(_ sender: Any) {
        onGameStart()
        
        playButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    @IBAction func onPauseButton(_ sender: Any) {
        onGamePause()
        
        playButton.isHidden = false
        playButton.setTitle("Continue", for: .normal)
        pauseButton.isHidden = true
    }
    
    //MARK: - Game Event Listener
    
    func onGameStart() {
        scene?.isPaused = false
    }
    
    func onGamePause() {
        scene?.isPaused = true
    }
    
    func onGameOver() {
        loadScene()
        scene?.isPaused = true
        
        playButton.isHidden = false
        playButton.setTitle("Play", for: .normal)
        pauseButton.isHidden = true
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

