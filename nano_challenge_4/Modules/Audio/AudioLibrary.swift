import Foundation

enum SongLibrary : String, CaseIterable {
    case main = "main_song.wav"
}

enum SoundEffectLibrary : String, CaseIterable {
    case correct_01 = "correct_01.wav"
    case correct_02 = "correct_02.wav"
    case incorrect = "incorrect.wav"
    case play = "play.wav"
}
