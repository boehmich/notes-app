//
//  MockData.swift
//  Notes
//
//  Created by Boehmich on 07.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import Foundation

class MockDataService{
    let repository = Repository()
    let dateFormatterService = DateFormatterService()
    
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
        let date1 = dateFormatterService.stringToDate(stringDate: "22.12.2021")
        let note1 = newNote(name: "erste Notiz", date: date1, entry: "Das ist der Eintrag der ersten Notiz!")
        repository.create(newNote: note1)
        
        let date2 = dateFormatterService.stringToDate(stringDate: "23.12.2021")
        let note2 = newNote(name: "zweite Notiz", date: date2, entry: "Das ist der Eintrag der zweiten Notiz!")
        repository.create(newNote: note2)
        
        let date3 = dateFormatterService.stringToDate(stringDate: "24.12.2021")
        let note3 = newNote(name: "dritte Notiz", date: date3, entry: "Heute ist Weihnachten!")
        repository.create(newNote: note3)
    }
    
    private func stringToDateFormatter(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
        return dateFormatter.date(from: date)!
    }

}
