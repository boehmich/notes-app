//
//  EntryViewController.swift
//  Notes
//
//  Created by Boehmich on 04.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class EntryViewController: UIViewController, UITextViewDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    let repository = Repository()
    let recorderService = AVAudioRecorderPlayerService()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var soundFileUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTextView.delegate = self
        entryTextView.text! = NSLocalizedString("placeholder_entry", comment: "")
        nameLabel.text! = "\(NSLocalizedString("name", comment: "")):"
        dateLabel.text! = "\(NSLocalizedString("date", comment: "")):"
        entryLabel.text! = "\(NSLocalizedString("entry", comment: "")):"
        saveButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        
        recorderService.prepareAudioRecorder()
    }

    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.text! == NSLocalizedString("placeholder_entry", comment: "") {
            textView.text! = ""
        }
    }
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        recorderService.startRecording()
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        recorderService.stopRecording()
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let note = newNote(name: nameTextField.text!, date: dateTextField.text!, entry: entryTextView.text!)
    
        repository.create(newNote: note)
        
        recorderService.updateSoundFileUrl(fileName: nameTextField.text!)
        
        finishProcess()
    }
    
    func finishProcess(){
        nameTextField.text! = ""
        dateTextField.text! = ""
        entryTextView.text! = NSLocalizedString("placeholder_entry", comment: "")
        
        self.tabBarController?.selectedIndex = 0
        
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
