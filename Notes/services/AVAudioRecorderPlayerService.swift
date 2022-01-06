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
    
    var soundFileUrl: URL!
    let defaultName: String = "note"
    var recordingSettings: [String : Any]!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    
    func prepareAudioRecorder(){
        setSoundFile(soundFileName: defaultName)

        setAudioSession()
        
        setRecordingSettings()
    }
    
    func prepareAudioPlayer(noteName: String){
        setSoundFile(soundFileName: noteName)
        
        setAudioSession()
    }
    
    private func setSoundFile(soundFileName: String){
        let fileManager = FileManager.default
        let dirPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        soundFileUrl = dirPath[0].appendingPathComponent("\(soundFileName).caf")
        
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
    
    func updateSoundFileUrl(fileName: String){
        let documentDirectory = getDocumentDirectory()
        let originPath = documentDirectory.appendingPathComponent("\(defaultName).caf")
        let destinationPath = documentDirectory.appendingPathComponent("\(fileName).caf")
        
        do {
            try FileManager.default.moveItem(at: originPath, to: destinationPath)
        } catch {
            print(error)
        }
    }
    
    func deleteSoundFile(noteName: String){
        let documentDirectory = getDocumentDirectory()
        let path = documentDirectory.appendingPathComponent("\(noteName).caf")
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print(error)
        }
    }
    
    private func getDocumentDirectory() -> URL{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return URL(fileURLWithPath: path)
    }
}
