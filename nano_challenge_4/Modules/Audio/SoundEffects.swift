import AVFoundation

class SoundEffect {
    
    private var players = [AVAudioPlayer]()
    private var url: URL!
    
    init(fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType : nil)!
        url = URL(fileURLWithPath: path)

        self.loadNewPlayer()
    }
    
    private func loadNewPlayer() {
        do {
            let Newplayer = try AVAudioPlayer(contentsOf: url)
            Newplayer.prepareToPlay()
            
            self.players.append(Newplayer)
        } catch {
            fatalError("Fatal Error - Sound Effects Player")
        }
    }
    
    func play() {
        for player in players {
            if !player.isPlaying {
                DispatchQueue.global().async {
                    player.play()
                }
                return
            }
        }
        
        self.loadNewPlayer()
        
        DispatchQueue.global().async {
            self.players.last?.play()
        }
        
    }
}
