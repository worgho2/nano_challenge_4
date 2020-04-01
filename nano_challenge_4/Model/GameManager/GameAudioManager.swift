//
//  GameSoundManager.swift
//  nano_challenge_4
//
//  Created by otavio on 16/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import AVFoundation
import SpriteKit

class GameAudioManager {
    
    private var songs = [SongLibrary : Song]()
    private var soundEffects = [SoundEffectLibrary : SoundEffect]()

    init() {
        SongLibrary.allCases.forEach { songs[$0] = Song(fileName: $0.rawValue) }
        SoundEffectLibrary.allCases.forEach { soundEffects[$0] = SoundEffect(fileName: $0.rawValue) }
    }
    
    func play(soundEffect: SoundEffectLibrary) {
        soundEffects[soundEffect]?.play()
    }
    
    func play(song: SongLibrary) {
        songs[song]?.play()
    }
    
    func pause() {
        songs.forEach( { $0.value.pause() } )
    }

    func stopCurrentSongs() {
        songs.forEach( { $0.value.stop() } )
    }
    
}
