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

class NoteViewController: UIViewController, UIAlertViewDelegate {
    let repository = Repository()
    let audioService = AVAudioRecorderPlayerService()
    let dateFormatterService = DateFormatterService()
    let fileManagerService = FileManagerService()
    let alertDialogService = AlertDialogService()
    var note: NSManagedObject?
    var name: String!
     
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.setTitle(NSLocalizedString("delete", comment: ""), for: .normal)
        playButton.setTitle(NSLocalizedString("voice_message", comment: ""), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFields()
        name = nameLabel.text!
        checkIfSoundFileAvailable()
        audioService.prepareAudioPlayer(noteName: name)
    }
    
    private func setFields(){
        let noteDate = note?.value(forKey: "date") as? Date
        let date = dateFormatterService.dateToString(date: noteDate!)
        
        nameLabel.text = note?.value(forKey: "name") as? String
        dateLabel.text = date
        entryTextView.text = note?.value(forKey: "entry") as? String
    }
    
    private func checkIfSoundFileAvailable(){
        if(!fileManagerService.isSoundFileUrlAvailable(fileName: name)){
            playButton.isHidden = true
        }
        
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        let alertController = alertDialogService.getAlertController(title: name, deleteAction: finishDeleteProcess)
        
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    func finishDeleteProcess(){
        self.repository.delete(note: self.note as! Note)
        self.fileManagerService.deleteSoundFile(fileName: self.name)
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
 Dialog

 
       let alertController = UIAlertController(title: name, message: NSLocalizedString("delete_message", comment: ""), preferredStyle: .actionSheet)
       
       let deleteAction = UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .default) { (action) in
           self.repository.delete(note: self.note as! Note)
           self.fileManagerService.deleteSoundFile(fileName: self.name)
           self.navigationController!.popViewController(animated: true)
       }
       
       let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive, handler: nil)

       alertController.addAction(deleteAction)
       alertController.addAction(cancelAction)
       
       self.present(alertController, animated: true, completion: nil)
*/

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

       
