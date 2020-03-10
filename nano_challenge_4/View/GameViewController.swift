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
    
    @IBOutlet weak var skView: SKView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    weak var scene: GameScene?
    
    private func loadScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            scene.scaleMode = .aspectFill
            
            scene.vc = self
            scene.gameColorPalette = GameColorPalette(generator: PaletteGenerator(baseHSV: HSV(hue: CGFloat.random(in: 0...360), saturation: CGFloat.random(in: 0.5...1), value: 1)))
            scene.backgroundColor = scene.gameColorPalette!.backgroundColor
            
            self.scene = scene
            skView.presentScene(scene)
        }
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
    
    func onGameStart() {
        scene?.realPaused = false
    }
    
    func onGamePause() {
        scene?.realPaused = true
    }
    
    func onGameOver() {
        loadScene()
        scene?.realPaused = true
        
        playButton.isHidden = false
        playButton.setTitle("Play", for: .normal)
        pauseButton.isHidden = true
    }
    
    //MARK: - View Setup
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = self.scene?.gameColorPalette?.backgroundColor
        self.skView.backgroundColor = self.scene?.gameColorPalette?.backgroundColor
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

