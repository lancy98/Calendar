//
//  Additions.swift
//  CalendarLogic
//
//  Created by Lancy on 01/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func date(day: Int, month: Int, year: Int) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let dayString = String(format: "%02d", day)
        let monthString = String(format: "%02d", month)
        let yearString = String(format: "%04d", year)
        
        return dateFormatter.dateFromString(dayString + "/" + monthString + "/" + yearString)!
    }
   
    var startOfDay: NSDate {
        let components = self.components
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    var endOfTheDay: NSDate {
        let components = self.components
        
        components.hour = 23
        components.minute = 59
        components.second = 59
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }

    var firstDayOfTheMonth: NSDate {
        var date: NSDate?
        NSCalendar.currentCalendar().rangeOfUnit(.Month, startDate:&date , interval: nil, forDate: self)
        return date!
    }

    var firstDayOfPreviousMonth: NSDate {
        return firstDay(false)
    }
    
    var firstDayOfFollowingMonth: NSDate {
        return firstDay(true)
    }
    
    var monthDayAndYearComponents: NSDateComponents {
        let components: NSCalendarUnit = [.Year, .Month, .Day]
        return NSCalendar.currentCalendar().components(components, fromDate: self)
    }
    
    var weekDay: Int {
        return components.weekday
    }
    
    var numberOfDaysInMonth: Int {
        return NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
    }
    
    var day: Int {
        return components.day
    }
    
    var month: Int {
        return components.month
    }
    
    var year: Int {
        return components.year
    }
    
    var minute: Int {
        return components.minute
    }
    
    var second: Int {
        return components.second
    }
    
    var hour: Int {
        return components.hour
    }
    
    //MARK: Private variable and methods.
    
    private var components: NSDateComponents {
        let calendarUnit = NSCalendarUnit(rawValue: UInt.max)
        let components = NSCalendar.currentCalendar().components(calendarUnit, fromDate: self)
        return components
    }
    
    private func firstDay(followingMonth: Bool) -> NSDate {
        let dateComponent = NSDateComponents()
        dateComponent.month = followingMonth ? 1: -1
        
        let date = NSCalendar.currentCalendar().dateByAddingComponents(dateComponent, toDate: self, options: NSCalendarOptions(rawValue: 0))
        return date!.firstDayOfTheMonth
    }
}
