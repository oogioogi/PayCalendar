//
//  SoundManager.swift
//  WheelView
//
//  Created by 이용석 on 2022/05/14.
//

//SoundManager.avkit.playSound(sound: .camera1)

import Foundation
import AVKit

enum Sounds: String {
    case camera1
    case camera2
    case camera3
}

class SoundManager {
    
    static var avkit = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: Sounds) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        }catch let error {
            print("Sounds Error : \(error.localizedDescription)")
        }
    }
    
}
