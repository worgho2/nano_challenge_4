//
//  GameSoundManager.swift
//  nano_challenge_4
//
//  Created by otavio on 16/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import AVFoundation

class GameAudioManager {
    
    private var soundEffects = [SoundEffectLibrary : SoundEffect]()
    private var songs = [SongLibrary : Song]()
    private var introsWithLoops = [IntroWithLoopLibrary : Song]()

    init() {
        SoundEffectLibrary.allCases.forEach( { soundEffects[$0] = SoundEffect(fileName: $0.rawValue) } )
        SongLibrary.allCases.forEach( { songs[$0] = Song(fileName: $0.rawValue) } )
        IntroWithLoopLibrary.allCases.forEach( { introsWithLoops[$0] = IntroWithLoop(introFileName: $0.info.intro, loopFileName: $0.info.loop) } )
    }
    
    func play(soundEffect: SoundEffectLibrary) {
        soundEffects[soundEffect]?.play()
    }
    
    func play(song: SongLibrary) {
        stopSongs()
        stopIntrosWithLoops()
        songs[song]?.play()
    }
    
    func play(introWithLoop: IntroWithLoopLibrary) {
        stopSongs()
        stopIntrosWithLoops()
        introsWithLoops[introWithLoop]?.play()
    }
    
    func stopCurrentSong() {
        stopIntrosWithLoops()
        stopSongs()
    }
    
    private func stopSongs() {
        songs.forEach( { $0.value.stop() } )
    }
    
    private func stopIntrosWithLoops() {
        introsWithLoops.forEach( { $0.value.stop() } )
    }
    
}
