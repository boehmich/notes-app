//
//  Repository.swift
//  Notes
//
//  Created by Boehmich on 05.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Repository {
    
    var managedContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return (appDelegate?.persistentContainer.viewContext)!
    }
    
    
    func create(newNote: newNote){
        let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        let note = NSManagedObject(entity: noteEntity, insertInto: managedContext)
        note.setValue(newNote.name, forKey: "name")
        note.setValue(newNote.date, forKey: "date")
        note.setValue(newNote.entry, forKey: "entry")
        
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func readAll() -> Array<Note>{
        let noteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
               
        let notes = try! managedContext.fetch(noteFetch) as! [Note]
       
        return notes
    }
    
    func delete(note: Note){
        managedContext.delete(note)
        
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
