//
//  Date+Additions.swift
//  CalendarLogic
//
//  Created by Lancy on 01/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import Foundation

extension Date {
    
    static func date(day: Int, month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        return Calendar.current.date(from: dateComponents)!
    }
   
    var startOfDay: Date {
        var components = dateComponents
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return Calendar.current.date(from: components)!
    }
    
    var endOfTheDay: Date {
        var components = dateComponents
        
        components.hour = 23
        components.minute = 59
        components.second = 59
        
        return Calendar.current.date(from: components)!
    }

    var firstDayOfTheMonth: Date {
        let startOfDay = Calendar.current.startOfDay(for: self)
        let dateComponents = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: dateComponents)!
    }

    var firstDayOfPreviousMonth: Date {
        return firstDay(followingMonth: false)
    }
    
    var firstDayOfFollowingMonth: Date {
        return firstDay(followingMonth: true)
    }
    
    var monthDayAndYearComponents: DateComponents {
        return dateComponents(components: [.month, .year])
    }
    
    var weekDay: Int {
        return dateComponents.weekday!
    }
    
    var numberOfDaysInMonth: Int {
        return Calendar.current.range(of: .day, in: .month, for: self)!.count
    }
    
    var day: Int {
        return dateComponents.day!
    }

    var month: Int {
        return dateComponents.month!
    }

    var year: Int {
        return dateComponents.year!
    }
    
    var minute: Int {
        return dateComponents.minute!
    }
    
    var second: Int {
        return dateComponents.second!
    }
    
    var hour: Int {
        return dateComponents.hour!
    }
    
    //MARK: Private variable and methods.
    
    private var dateComponents: DateComponents {
        return dateComponents(components: [.second, .hour, .day, .weekday, .month, .year])
    }
    
    private func dateComponents(components: Set<Calendar.Component>) -> DateComponents {
        let components = Calendar.current.dateComponents(components, from: self)
        return components
    }
    
    private func firstDay(followingMonth: Bool) -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = followingMonth ? 1: -1
        
        let date = Calendar.current.date(byAdding: dateComponent, to: self)
        return date!.firstDayOfTheMonth
    }
}
