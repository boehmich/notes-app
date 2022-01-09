//
//  AVAudioRecorderPlayerService.swift
//  Notes
//
//  Created by Boehmich on 06.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import Foundation
import AVFoundation

class AVAudioRecorderPlayerService{
    let fileManagerService = FileManagerService()
    
    var soundFileUrl: URL!
    var recordingSettings: [String : Any]!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    
    func prepareAudioRecorder(){
        soundFileUrl = fileManagerService.getSoundFileUrl(soundFileName: Constants.defaultSoundFileName)
        
        setAudioSession()
        
        setRecordingSettings()
    }
    
    func prepareAudioPlayer(noteName: String){
        soundFileUrl = fileManagerService.getSoundFileUrl(soundFileName: noteName)
        
        setAudioSession()
    }
    
    private func setAudioSession(){
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try
                audioSession.setCategory(.playAndRecord, mode: .default)
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func setRecordingSettings(){
        recordingSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
    }

    func startRecording(){
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileUrl, settings: recordingSettings as [String : Any])
            audioRecorder.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }

        audioRecorder.record()
    }
    
    func stopRecording(){
        audioRecorder.stop()
    }
    
    func play(){
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: soundFileUrl!)
            audioPlayer?.delegate = self as? AVAudioPlayerDelegate
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch let error as NSError {
            print(error)
        }
    }
}
