//
//  GameViewController.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit
import GameKit
import SpriteKit
import GoogleMobileAds
import FirebaseAnalytics

class GameViewController: UIViewController, TriggeredByGameState, Updateable {
    
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var gameCenterButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var highScoreObstacleLabel: UILabel!
    @IBOutlet weak var highScoreTimeLabel: UILabel!
    
    @IBOutlet weak var highScoreDefaultLabel: UILabel!
    @IBOutlet weak var bestTimeDefaultLabel: UILabel!
    
    var ad: GADInterstitial!
    var rewardedAd: GADRewardedAd!
    
    weak var scene: GameScene?
    
    var backgroundView: UIView!
    var viewPattern: UIView!
    
    private var isGamePaused: Bool = false

    
    //MARK: - Notification Center Methods
    
    @objc func onHighScoreNotification(_ notification: NSNotification) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (t) in
            self.highScoreObstacleLabel.text = "\(self.scene!.score.gameScoreManager.getHighScore().obstacle)"
            t.invalidate()
        }
    }

    @objc func onBestTimeNotification(_ notification: NSNotification) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (t) in
            self.highScoreTimeLabel.text = "\(String(format: "%0.2f", (self.scene?.score.gameScoreManager.getHighScore().time)!))s"
        }
    }
    
    //MARK: - Class Methods
    
    @IBAction func onGameCenterButton(_ sender: Any) {
        GameCenterSingleton.instance.presentGameCenterView(self)
    }
    
    @IBAction func onPlayButton(_ sender: Any) {
        self.scene?.play(isGamePaused: self.isGamePaused)
    }
    
    @IBAction func onPauseButton(_ sender: Any) {
        self.scene?.pause()
    }
    
    private func loadGame() {
        self.setupBackground()
        self.loadScene()
        self.setupView()
    }
    
    private func loadScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            
            scene.realPaused = true
            scene.scaleMode = .aspectFill
            scene.vc = self
            scene.backgroundColor = .clear
            
            backgroundView.backgroundColor = scene.gameColorManager.backgroundColor
            viewPattern.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 10)
            let image = UIImage(named: "background")!.tint(tintColor: scene.gameColorManager.pattern).resizeImage(size: CGSize(width: view.frame.width/2, height: view.frame.width/2))!
            viewPattern.backgroundColor = UIColor(patternImage: image)
            
            self.scene = scene
            
            let colorTop =  UIColor.clear.cgColor
            let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = skView.bounds
            
            skView.layer.insertSublayer(gradientLayer, at: 0)
            skView.backgroundColor = .clear
            skView.isMultipleTouchEnabled = true
            skView.presentScene(scene)
        }
    }
    
    private func setupBackground() {
        backgroundView = UIView(frame: view.frame)
        view.addSubview(backgroundView)
        
        viewPattern = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 10))
        viewPattern.alpha = 0.4
        view.addSubview(viewPattern)
        
        view.sendSubviewToBack(viewPattern)
        view.sendSubviewToBack(backgroundView)
    }
    
    private func setupView() {
        self.gameCenterButton.isHidden = false
        
        self.playButton.isHidden = false
        self.highScoreTimeLabel.isHidden = false
        self.highScoreObstacleLabel.isHidden = false
        self.pauseButton.isHidden = true
        self.highScoreDefaultLabel.isHidden = false
        self.bestTimeDefaultLabel.isHidden = false
        
        self.playButton.titleLabel?.textColor = .white
        self.playButton.tintColor = .white
        self.highScoreTimeLabel.textColor = .white
        self.highScoreObstacleLabel.textColor = .white
        self.pauseButton.titleLabel?.textColor = .white
        
        self.playButton.setTitle("Play", for: .normal)
        self.highScoreTimeLabel.text = "\(String(format: "%0.2f", (self.scene?.score.gameScoreManager.getHighScore().time)!))s"
        self.highScoreObstacleLabel.text = "\(self.scene!.score.gameScoreManager.getHighScore().obstacle)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onHighScoreNotification(_:)), name: Leaderboard.highScore.notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBestTimeNotification(_:)), name: Leaderboard.bestTime.notificationName, object: nil)
        
        self.loadInterAD()
        
        self.loadGame()
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
    
    //MARK: - Updateable PROTOCOL
    
    func update(_ deltaTime: TimeInterval) {
        let dY = CGFloat(deltaTime) * self.scene!.gameSpeedManager.getCurrentSpeed()
        self.viewPattern.center.y -= dY
        
        guard let frame = view?.frame else { return }
        
        if self.viewPattern.center.y <= 0 {
            self.viewPattern.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 10)
        }
    }
    
    //MARK: - TriggeredByGameState PROTOCOL (AJUSTAR PARA NOVA LÓGICA)
    
    func onGameStart() {
        self.gameCenterButton.isHidden = true
        
        self.playButton.isHidden = true
        self.pauseButton.isHidden = false
        self.highScoreObstacleLabel.isHidden = true
        self.highScoreTimeLabel.isHidden = true
        self.highScoreDefaultLabel.isHidden = true
        self.bestTimeDefaultLabel.isHidden = true
        
        self.playButton.setTitle("Continue", for: .normal)
    }
    
    func onGamePause() {
        self.isGamePaused = true
        
        self.gameCenterButton.isHidden = true
        
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
        self.highScoreObstacleLabel.isHidden = true
        self.highScoreTimeLabel.isHidden = true
        self.highScoreDefaultLabel.isHidden = true
        self.bestTimeDefaultLabel.isHidden = true
    }
    
    func onGameContinue() {
        self.isGamePaused = false
        
        self.gameCenterButton.isHidden = true
        
        self.playButton.isHidden = true
        self.pauseButton.isHidden = false
        self.highScoreObstacleLabel.isHidden = true
        self.highScoreTimeLabel.isHidden = true
        self.highScoreDefaultLabel.isHidden = true
        self.bestTimeDefaultLabel.isHidden = true
    }
    
    func onGameOver() {
        self.playButton.setTitle("Play", for: .normal)
        self.highScoreTimeLabel.text = "\(String(format: "%0.2f", self.scene!.score.gameScoreManager.getHighScore().time))s"
        self.highScoreObstacleLabel.text = "\(self.scene!.score.gameScoreManager.getHighScore().obstacle)"
        
        self.gameCenterButton.isHidden = false
        
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
        self.highScoreObstacleLabel.isHidden = false
        self.highScoreTimeLabel.isHidden = false
        self.highScoreDefaultLabel.isHidden = false
        self.bestTimeDefaultLabel.isHidden = false
        
        let random = Int.random(in: 0...100)
        print(random)
        
        if random > 60 {
            self.showInterAD()
        }
    }
}

extension GameViewController: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("o usuário ganhou:", reward.amount, reward.type)
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.loadAD()
    }
    
    func loadAD() {
        //        let id = "ca-app-pub-3805796666758486/3142948489"
        let id = "ca-app-pub-3940256099942544/1712485313"
        let newAd = GADRewardedAd(adUnitID: id)
        
        newAd.load(GADRequest()) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        self.rewardedAd = newAd
    }
    
    func showAD() {
        self.rewardedAd.present(fromRootViewController: self, delegate: self)
    }
}

extension GameViewController: GADInterstitialDelegate {
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("cebolinha do condor", error)
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.loadInterAD()
    }
    
    func loadInterAD() {
        //let id = "ca-app-pub-3805796666758486/8999632594" //meuad
        let id = "ca-app-pub-3940256099942544/4411468910"
        let newAdd = GADInterstitial(adUnitID: id)
        
        newAdd.delegate = self
        newAdd.load(GADRequest())
        
        self.ad = newAdd
    }
    
    func showInterAD() {
        guard self.ad.isReady else {
            return
        }
        
        self.ad.present(fromRootViewController: self)
    }
}
