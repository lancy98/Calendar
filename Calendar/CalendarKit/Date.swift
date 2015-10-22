//
//  Date.swift
//  CalendarLogic
//
//  Created by Lancy on 01/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import Foundation

class Date: CustomStringConvertible, Equatable {
    
    var day: Int
    var month: Int
    var year: Int
    
    var isToday: Bool {
        let today = Date(date: NSDate())
        return (isEqual(today) == .OrderedSame)
    }
    
    func isEqual(date: Date) -> NSComparisonResult {
        let selfComposite = (year * 10000) + (month * 100) + day
        let otherComposite = (date.year * 10000) + (date.month * 100) + date.day
        
        if selfComposite < otherComposite {
            return .OrderedAscending
        } else if selfComposite == otherComposite {
            return .OrderedSame
        } else {
            return .OrderedDescending
        }
    }
    
    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    init(date: NSDate) {
        let part = date.monthDayAndYearComponents
        
        self.day = part.day
        self.month = part.month
        self.year = part.year
    }
    
    var nsdate: NSDate {
        return NSDate.date(day, month: month, year: year)
    }
    
    var description: String {
        return "\(day)-\(month)-\(year)"
    }
}

func ==(lhs: Date, rhs: Date) -> Bool {
    return ((lhs.day == rhs.day) && (lhs.month == rhs.month) && (lhs.year == rhs.year))
}
