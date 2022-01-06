//
//  NoteViewController.swift
//  Notes
//
//  Created by Boehmich on 05.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class NoteViewController: UIViewController {
    let repository = Repository()
    let audioService = AVAudioRecorderPlayerService()
    var note: NSManagedObject?
    var name: String!
     
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.setTitle(NSLocalizedString("delete", comment: ""), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFields()
        name = nameLabel.text!
        audioService.prepareAudioPlayer(noteName: name)
    }
    
    func setFields(){
        nameLabel.text = note?.value(forKey: "name") as? String
        dateLabel.text = note?.value(forKey: "date") as? String
        entryTextView.text = note?.value(forKey: "entry") as? String
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        repository.delete(note: note as! Note)
        audioService.deleteSoundFile(noteName: name)
        self.navigationController!.popViewController(animated: true)
    }
    
    
    @IBAction func playVoiceMessage(_ sender: Any) {
        audioService.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*
 var audioPlayer: AVAudioPlayer!
 var soundFileUrl: URL?
 
 func setupAudioPlayer(){
     let fileManager = FileManager.default
     let dirPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
     let fileName = nameLabel.text!
     soundFileUrl = dirPath[0].appendingPathComponent("\(String(describing: fileName)).caf")
     print(soundFileUrl!)
     
     let audioSession = AVAudioSession.sharedInstance()
     
     do {
         try
             audioSession.setCategory(.playAndRecord, mode: .default)
     } catch let error as NSError {
         print(error)
     }
 }
 
 func play (){
     do{
               try audioPlayer = AVAudioPlayer(contentsOf: soundFileUrl!)
               audioPlayer?.delegate = self as? AVAudioPlayerDelegate
               audioPlayer?.prepareToPlay()
               audioPlayer?.play()
           } catch let error as NSError {
               print(error)
           }
     }
 */

       
