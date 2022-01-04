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


struct NotesTableEntity {
    var name: String
    var date: String
    var entry: String
}

class NotesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var notesList = [NotesTableEntity]()
    
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
        
        let noteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
               
        let notes = try! managedContext.fetch(noteFetch) as! [Note]
               
        for note in notes {
            notesList.append(NotesTableEntity(name: note.name!, date: note.date!, entry: note.entry!))
        }
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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
