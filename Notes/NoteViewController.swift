//
//  NoteViewController.swift
//  Notes
//
//  Created by Boehmich on 05.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import UIKit
import CoreData
import SwiftUI

class NoteViewController: UIViewController {
    let repository = Repository()
    var note: NSManagedObject?
     
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNote()
    }
    
    func loadNote(){
        nameLabel.text = note?.value(forKey: "name") as? String
        dateLabel.text = note?.value(forKey: "date") as? String
        entryTextView.text = note?.value(forKey: "entry") as? String
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(note!)
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        self.navigationController!.popViewController(animated: true)
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
       print(note?.value(forKey: "name") ?? "any Name")
       print(note?.value(forKey: "date") ?? "any Date")
       print(note?.value(forKey: "entry") ?? "any Entry")
*/
       
