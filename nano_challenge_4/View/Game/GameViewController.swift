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

class GameViewController: UIViewController {
    
    enum ViewGameState {
        case playing
        case paused
        case waitingForStart
    }
    
    @IBOutlet weak var coverView: UIView!
    
    weak var scene: GameScene?
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var gameCenterButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var highScoreDefaultLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var bestTimeDefaultLabel: UILabel!
    @IBOutlet weak var bestTimeLabel: UILabel!
    
    @IBOutlet weak var timeDefaultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreDefaultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //TODO: - GameADSManager
    var ad: GADInterstitial!
    var rewardedAd: GADRewardedAd!
    
    //passar o conhecimento para dentro da scene
    private var isGamePaused: Bool = false
    
    //MARK: - Notification Center Methods
    
    private func loadNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onHighScoreNotification(_:)), name: Leaderboard.highScore.notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBestTimeNotification(_:)), name: Leaderboard.bestTime.notificationName, object: nil)
    }
    
    @objc func onHighScoreNotification(_ notification: NSNotification) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (t) in
            let score = self.scene!.gameManager.score.getHighScore().obstacle
            self.highScoreLabel.text = score < 10 ? "00\(score)" : (score < 100 ? "0\(score)" : "\(score)" )
            t.invalidate()
        }
    }
    
    @objc func onBestTimeNotification(_ notification: NSNotification) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (t) in
            self.bestTimeLabel.text = self.scene!.gameManager.score.getHighScore().time.asString()
            t.invalidate()
        }
    }
    
    //MARK: - Button Actions
    
    @IBAction func onGameCenterButton(_ sender: Any) {
        GameCenterSingleton.instance.presentGameCenterView(self)
    }
    
    @IBAction func onPlayButton(_ sender: Any) {
        self.scene?.play()
    }
    
    @IBAction func onPauseButton(_ sender: Any) {
        self.scene?.pause(isGamePaused: self.isGamePaused)
    }
    
    //MARK: - Load Methods
    
    private func loadScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {

            scene.realPaused = true
            scene.scaleMode = .resizeFill
//            scene.scaleMode = .aspectFill //arruma isso
            scene.vc = self
            self.scene = scene
            
            let colorTop =  UIColor.clear.cgColor
            let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = skView.bounds
            
            skView.layer.insertSublayer(gradientLayer, at: 0)
            skView.backgroundColor = .white
            skView.isMultipleTouchEnabled = true
            
            skView.presentScene(scene)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadScene()
        self.loadUI()
        self.loadInterAD()
        self.loadNotificationObservers()
    }
    
    //MARK: - View Setup
    private func setButtonsTo(state: ViewGameState) {
        
        switch state {
            
        case .playing:
            //GameCenterButton
            self.gameCenterButton.isHidden = true
            self.gameCenterButton.alpha = 0
            
            //PlayButton
            self.playButton.isHidden = true
            
            //PauseButton
            self.pauseButton.isHidden = scene!.gameManager.onboarding.onboardingIsNeeded() ? true : false
            
            if #available(iOS 13.0, *) {
                self.pauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill")!, for: .normal)
            } else {
                self.pauseButton.setBackgroundImage(UIImage(named: "pause")!, for: .normal)
            }
            
        case .paused:
            //GameCenterButton
            self.gameCenterButton.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.gameCenterButton.alpha = 1
            })
            
            //PlayButton
            self.playButton.isHidden = true
            
            //PauseButton
            self.pauseButton.isHidden = scene!.gameManager.onboarding.onboardingIsNeeded() ? true : false
            
            if #available(iOS 13.0, *) {
                self.pauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill")!, for: .normal)
            } else {
                self.pauseButton.setBackgroundImage(UIImage(named: "play")!, for: .normal)
            }

        case .waitingForStart:
            //GameCenterButton
            self.gameCenterButton.isHidden = false
            self.gameCenterButton.alpha = 1
            
            //PlayButton
            self.playButton.isHidden = false
            self.playButton.setTitle("Play", for: .normal)
            
            //PlayButton
            self.pauseButton.isHidden = true
        }
        
    }
    
    private func setHighScoresTo(state: ViewGameState) {
        
        switch state {
            
        case .playing:
            self.highScoreDefaultLabel.isHidden = true
            self.highScoreLabel.isHidden = true
            self.bestTimeDefaultLabel.isHidden = true
            self.bestTimeLabel.isHidden = true
            
        case .paused:
            self.highScoreDefaultLabel.isHidden = true
            self.highScoreLabel.isHidden = true
            self.bestTimeDefaultLabel.isHidden = true
            self.bestTimeLabel.isHidden = true
            
        case .waitingForStart:
            self.highScoreDefaultLabel.isHidden = false
            self.highScoreLabel.isHidden = false
            
            let score = self.scene!.gameManager.score.getHighScore().obstacle
            self.highScoreLabel.text = score < 10 ? "00\(score)" : (score < 100 ? "0\(score)" : "\(score)" )
            self.bestTimeDefaultLabel.isHidden = false
            self.bestTimeLabel.isHidden = false
            self.bestTimeLabel.text = self.scene!.gameManager.score.getHighScore().time.asString()

        }
        
    }
    
    private func setScoresTo(state: ViewGameState) {
        
        switch state {
            
        case .playing:
            if !scene!.gameManager.onboarding.onboardingIsNeeded() {
                self.timeDefaultLabel.isHidden = false
                self.timeLabel.isHidden = false
                self.scoreDefaultLabel.isHidden = false
                self.scoreLabel.isHidden = false
            }

        case .paused:
            if !scene!.gameManager.onboarding.onboardingIsNeeded() {
                self.timeDefaultLabel.isHidden = false
                self.timeLabel.isHidden = false
                self.scoreDefaultLabel.isHidden = false
                self.scoreLabel.isHidden = false
            }
            
        case .waitingForStart:
            self.timeDefaultLabel.isHidden = true
            self.timeLabel.isHidden = true
            self.scoreDefaultLabel.isHidden = true
            self.scoreLabel.isHidden = true

        }
        
    }
    
    private func setCoverViewTo(state: ViewGameState) {
        
        switch state {
        case .playing:
            self.coverView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.coverView.alpha = 0
            }) { (_) in
                self.coverView.isHidden = true
            }
            
        case .paused:
            self.coverView.isUserInteractionEnabled = false
            self.coverView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.coverView.alpha = 1
            })
            
        case .waitingForStart:
            self.coverView.isUserInteractionEnabled = false
            self.coverView.isHidden = true
            self.coverView.alpha = 0
        }
        
    }
    
    private func setUITo(state: ViewGameState) {
        self.setButtonsTo(state: state)
        self.setHighScoresTo(state: state)
        self.setScoresTo(state: state)
        self.setCoverViewTo(state: state)
    }
    
    private func loadUI() {
        self.playButton.titleLabel!.textColor = .white
        self.playButton.tintColor = .white
        
        self.pauseButton.titleLabel!.textColor = .white
        self.pauseButton.tintColor = .white
        
        self.highScoreDefaultLabel.textColor = .white
        self.highScoreLabel.textColor = .white
        self.bestTimeDefaultLabel.textColor = .white
        self.bestTimeLabel.textColor = .white
        
        self.scoreDefaultLabel.textColor = .white
        self.scoreLabel.textColor = .white
        self.timeDefaultLabel.textColor = .white
        self.timeLabel.textColor = .white
        
        self.setUITo(state: .waitingForStart)
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

extension GameViewController: InterfaceDelegate {
    
    func sendScore(score: Int, time: TimeInterval) {
        self.scoreLabel.text = score < 10 ? "00\(score)" : (score < 100 ? "0\(score)" : "\(score)" )
        
        self.timeLabel.text = time.asString()
    }
    
}

extension GameViewController: TriggeredByGameState {
    
    func onGameStart() {
        self.setUITo(state: .playing)
    }
    
    func onGamePause() {
        self.isGamePaused = true
        self.setUITo(state: .paused)
    }
    
    func onGameContinue() {
        self.isGamePaused = false
        self.setUITo(state: .playing)
    }
    
    func onGameOver() {
        self.setUITo(state: .waitingForStart)
        
        //vai sair com o ad Manager
        if Int.random(in: 0...100) > 60 {
//            self.showInterAD()
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
        print("[INTERSTITIAL-AD] - Error\(error)", error.localizedDescription)
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.loadInterAD()
    }
    
    func loadInterAD() {
        //        let id = "ca-app-pub-3940256099942544/4411468910" //debug
        let id = "ca-app-pub-3805796666758486/8999632594"
        let newAdd = GADInterstitial(adUnitID: id)
        
        newAdd.delegate = self
        newAdd.load(GADRequest())
        
        self.ad = newAdd
        
        print("[INTERSTITIAL-AD] - Loading ad (id: \(id))")
    }
    
    func showInterAD() {
        
        guard self.ad.isReady else {
            print("[INTERSTITIAL-AD] - Fail to present, ad is not ready")
            return
        }
        
        print("[INTERSTITIAL-AD] - Presenting ad (id: \(ad.adUnitID!))")
        self.ad.present(fromRootViewController: self)
    }
    
}
