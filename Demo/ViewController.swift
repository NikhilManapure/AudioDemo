//
//  ViewController.swift
//  Demo
//
//  Created by Nikhil Manapure on 06/01/17.
//  Copyright © 2017 Demo. All rights reserved.
//

import UIKit
import AudioToolbox

enum SoundExtension : String{
    case caf
    case aif
    case wav
}

let  shortRing = "notification 1"

class ViewController: UIViewController {
    
    var notificationSoundLookupTable = [String: SystemSoundID]()
    var shouldPlaySoundEffects = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func play(_ sender: Any) {
        play(sound: shortRing, ofType: .wav)
    }
    
    func play(sound: String, ofType type: SoundExtension) {
        if let soundID = notificationSoundLookupTable[sound] {
            AudioServicesPlaySystemSound(soundID)
        } else {
             if let soundURL : CFURL = Bundle.main.url(forResource: sound, withExtension: type.rawValue) as CFURL? {
                var soundID  : SystemSoundID = 0
                let osStatus : OSStatus = AudioServicesCreateSystemSoundID(soundURL, &soundID)
                if osStatus == kAudioServicesNoError {
                    AudioServicesPlaySystemSound(soundID);
                    notificationSoundLookupTable[sound] = (soundID)
                }else{
                    // This happens in exceptional cases
                    // Handle it with no sound or retry
                }
            }
        }
    }
    
    func plafy(sound: String, ofType type: SoundExtension) {
        if let soundID = notificationSoundLookupTable[sound] {
            AudioServicesPlaySystemSound(soundID)
        } else {
            if let soundURL : CFURL = Bundle.main.url(forResource: sound,       withExtension: type.rawValue) as CFURL? {
                var soundID  : SystemSoundID = 0
                let osStatus : OSStatus = AudioServicesCreateSystemSoundID(soundURL, &soundID)
                if osStatus == kAudioServicesNoError {
                    AudioServicesPlaySystemSound(soundID);
                    notificationSoundLookupTable[sound] = (soundID)
                }else{
                    // This happens in exceptional cases
                    // Handle it with no sound or retry
                }
            }
        }
    }
    
    func disposeSoundIDs() {
        for soundID in notificationSoundLookupTable.values {
            AudioServicesDisposeSystemSoundID(soundID)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.disposeSoundIDs()
    }

    deinit {
        self.disposeSoundIDs()
    }
}


