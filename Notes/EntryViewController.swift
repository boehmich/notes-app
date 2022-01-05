//
//  EntryViewController.swift
//  Notes
//
//  Created by Boehmich on 04.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import UIKit
import CoreData

class EntryViewController: UIViewController {
    var repository = Repository()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let note = newNote(name: nameTextField.text!, date: dateTextField.text!, entry: entryTextView.text!)
    
        repository.create(newNote: note)
        
        finishProcess()
    }
    
    func finishProcess(){
        nameTextField.text! = ""
        dateTextField.text! = ""
        entryTextView.text! = "Enter your note ..."
        
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

/*
 guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
     return
 }
 
 let managedContext = appDelegate.persistentContainer.viewContext
 
 
 */
