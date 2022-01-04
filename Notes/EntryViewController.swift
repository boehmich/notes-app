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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        let note = NSManagedObject(entity: noteEntity, insertInto: managedContext)
        note.setValue(nameTextField.text!, forKey: "name")
        note.setValue(dateTextField.text!, forKey: "date")
        note.setValue(entryTextView.text!, forKey: "entry")
        
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        let noteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let notes = try! managedContext.fetch(noteFetch) as! [Note]
        
        
        for note in notes {
            print(note.name!)
            print(note.date!)
            print(note.entry!)
        }
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
