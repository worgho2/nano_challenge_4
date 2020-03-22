import AVFoundation

class Song : NSObject {
    
    private var player: AVAudioPlayer!
    private var url: URL!
    
    init(fileName: String) {
        super.init()
        
        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
        
        self.url = URL(fileURLWithPath: path)
        
        self.loadPlayer()
    }
    
    private func loadPlayer() {
        do {
            let Newplayer = try AVAudioPlayer(contentsOf: url)
            Newplayer.numberOfLoops = -1
            Newplayer.prepareToPlay()
            Newplayer.volume = 0.05
            
            self.player = Newplayer
        } catch {
            fatalError("Fatal Error - Song/Intro-Loop Player")
        }
    }
    
    func play() {
        if player.isPlaying {
            player.stop()
        }
        
        DispatchQueue.global().async {
            self.player.play()
        }
    }
    
    func stop() {
        player.stop()
        player.currentTime = 0
    }
    
    func pause() {
        player.stop()
    }
}
