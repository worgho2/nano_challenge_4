import AVFoundation

enum SongLibrary : String, CaseIterable {
    case test = "Play 1.wav"
}

enum IntroWithLoopLibrary: CaseIterable {
    case test
    
    var info : (intro: String, loop: String) {
        switch self {
        case .test:
            return ("Play 1.wav", "Play 1.wav")
        }
    }
}

enum SoundEffectLibrary : String, CaseIterable {
    case play = "Play.wav"
    case play1 = "Play 1.wav"
    case play2 = "Play 2.wav"
    case splash = "Splash.wav"
    case waterDrop1 = "Water drop 1.wav"
    case waterDrop2 = "Water drop 2.wav"
    case waterDrop3 = "Water drop 3.wav"
    case waterDrop4 = "Water drop 4.wav"
}
