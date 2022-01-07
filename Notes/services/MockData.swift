//
//  MockData.swift
//  Notes
//
//  Created by Boehmich on 07.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import Foundation

class MockData{
    let repository = Repository()
    
    init() {
        let defaults = UserDefaults.standard
        let isMockDataCreated = defaults.bool(forKey: "mockDataCreated")
        if(!isMockDataCreated){
            createMockData()
            defaults.set(true, forKey: "mockDataCreated")
        }
        else{
            print("Mock data already created!")
        }
    }
    
    private func createMockData(){
        let note1 = newNote(name: "erste Notiz", date: "22.12.2021", entry: "Das ist der Eintrag der ersten Notiz!")
        repository.create(newNote: note1)
        
        let note2 = newNote(name: "zweite Notiz", date: "22.12.2021", entry: "Das ist der Eintrag der zweiten Notiz!")
        repository.create(newNote: note2)
        
        let note3 = newNote(name: "dritte Notiz", date: "24.12.2021", entry: "Heute ist Weihnachten!")
        repository.create(newNote: note3)
    }
    

}
