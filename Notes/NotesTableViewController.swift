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
    
    @IBOutlet weak var notesNameLabel: UILabel!
    @IBOutlet weak var notesDateLabel: UILabel!
    @IBOutlet weak var notesImageView: UIImageView!
}


class NotesTableViewController: UITableViewController {
    let repository = Repository()
    let mockDataService = MockDataService()
    let dateFormatterService = DateFormatterService()
    var notesList = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotesFromCoreData()
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        notesList = []
    }
    
    func loadNotesFromCoreData(){
        let notes = repository.readAll()
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
        
        cell.notesNameLabel?.text = note.name
        
        let date = dateFormatterService.dateToString(date: note.date!)
        cell.notesDateLabel?.text = date
        cell.notesImageView?.image = UIImage(named: "note")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("notes", comment: "")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
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
