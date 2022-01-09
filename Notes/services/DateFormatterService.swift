//
//  DateFormatter.swift
//  Notes
//
//  Created by Boehmich on 08.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import Foundation

class DateFormatterService{
    let dateFormatter: DateFormatter!
    
    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd.MM.yyyy"
    }
    
    func stringToDate(stringDate: String) -> Date {
        return dateFormatter.date(from: stringDate)!
    }
    
    func dateToString(date: Date) -> String {

        return dateFormatter.string(from: date)
    }
}

//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "dd.MM.yyyy"
//dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
