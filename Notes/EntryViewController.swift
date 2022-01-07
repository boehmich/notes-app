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

class EntryViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    let repository = Repository()
    let audioService = AVAudioRecorderPlayerService()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var voiceMessageLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingImageView: UIImageView!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        entryTextView.delegate = self
        dateTextField.delegate = self
        
        audioService.prepareAudioRecorder()
        styleRecordingImageView()
        
        setDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setCurrentDay()
    }
    
    func setCurrentDay(){
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: currentDateTime)
    }
    
    func setDatePicker(){
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)

    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func styleRecordingImageView(){
        recordingImageView.isHidden = true
        self.recordingImageView.layer.cornerRadius = self.recordingImageView.frame.size.height/2

    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.text! == NSLocalizedString("placeholder_entry", comment: "") {
            textView.text! = ""
        }
    }
    

    
    @IBAction func recordButtonPressed(_ sender: Any) {
        styleRecordButton()
        
        audioService.startRecording()
        
        recordingImageView.isHidden = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            self.animateImageView()
        }
        
    }
    private func styleRecordButton(){
        recordButton.isEnabled = false
        recordButton.backgroundColor = .lightGray
        recordButton.setTitleColor(UIColor.red, for: .normal)
        recordButton.layer.cornerRadius = 6
    }
    
    private func animateImageView(){
        
        self.recordingImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.recordingImageView.transform = .identity
            }, completion: nil)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        audioService.stopRecording()
        timer.invalidate()
        
        recordButton.backgroundColor = .white
        recordButton.setTitleColor(.black, for: .normal)
        recordButton.isEnabled = true
        recordingImageView.isHidden = true
        
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let note = newNote(name: nameTextField.text!, date: dateTextField.text!, entry: entryTextView.text!)
    
        repository.create(newNote: note)
        
        audioService.updateSoundFileUrl(fileName: nameTextField.text!)
        
        finishProcess()
    }
    
    func finishProcess(){
        nameTextField.text! = ""
        dateTextField.text! = ""
        entryTextView.text! = NSLocalizedString("placeholder_entry", comment: "")
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    private func setLocalization(){
        entryTextView.text! = NSLocalizedString("placeholder_entry", comment: "")
        nameLabel.text! = "\(NSLocalizedString("name", comment: "")):"
        dateLabel.text! = "\(NSLocalizedString("date", comment: "")):"
        entryLabel.text! = "\(NSLocalizedString("entry", comment: "")):"
        saveButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        voiceMessageLabel.text! = NSLocalizedString("voice_message", comment: "")
        recordButton.setTitle(NSLocalizedString("record", comment: ""), for: .normal)
        stopButton.setTitle(NSLocalizedString("stop", comment: ""), for: .normal)
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
