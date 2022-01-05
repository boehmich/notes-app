//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Boehmich on 04.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewCell: UITableViewCell{
    
    @IBOutlet weak var noticeName: UILabel!
    @IBOutlet weak var noticeDate: UILabel!
    @IBOutlet weak var noticeImageView: UIImageView!
}


class NotesTableViewController: UITableViewController {
    let repository = Repository()
    var notesList = [Note]()
    var selectedNote: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotesFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotesFromCoreData()
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        notesList = []
    }
    
    
    func loadNotesFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let notes = repository.readAll(appDelegat: appDelegate, managedContext: managedContext)
        
        notesList = notes
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesTableViewCell

        let note = notesList[indexPath.row]
        
        cell.noticeName?.text = note.name
        cell.noticeDate?.text = note.date
        cell.noticeImageView?.image = UIImage(named: "notiz")
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notizen"
    }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notesList[indexPath.row]
        self.performSegue(withIdentifier: "Note", sender: nil)
    }
    */
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Note" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let noteViewController = segue.destination as! NoteViewController
                noteViewController.note = notesList[indexPath.row]
            }
        }
    }
    

}
