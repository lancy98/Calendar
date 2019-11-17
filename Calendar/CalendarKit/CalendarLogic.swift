//
//  CalLogic.swift
//  CalendarLogic
//
//  Created by Lancy on 01/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import Foundation

class CalendarLogic {
    
    // Mark: Public variables and methods.
    var baseDate: Date {
        didSet {
            calculateVisibleDays()
        }
    }
    
    private lazy var dateFormatter = DateFormatter()
    
    var currentMonthAndYear: String {
        dateFormatter.dateFormat = "LLLL yyyy"
        return dateFormatter.string(from: baseDate)
    }

    var currentMonthDays: [Date]?
    var previousMonthVisibleDays: [Date]?
    var nextMonthVisibleDays: [Date]?
    
    init(date: Date) {
        baseDate = date.firstDayOfTheMonth
        calculateVisibleDays()
    }
    
    func retreatToPreviousMonth() {
        baseDate = baseDate.firstDayOfPreviousMonth
    }
    
    func advanceToNextMonth() {
        baseDate = baseDate.firstDayOfFollowingMonth
    }
    
    func moveToMonth(date: Date) {
        baseDate = date
    }
    
    func isVisible(date: Date) -> Bool {
        if currentMonthDays!.contains(date) {
            return true
        } else if previousMonthVisibleDays!.contains(date) {
            return true
        } else if nextMonthVisibleDays!.contains(date) {
            return true
        }
        return false
    }
    
    func containsDate(date: Date) -> Bool {
        if (date.month == baseDate.month) &&
            (date.year == baseDate.year) {
            return true
        }
        
        return false
    }
    
    //Mark: Private methods.
    private var numberOfDaysInPreviousPartialWeek: Int {
        return baseDate.weekDay - 1
    }
    
    private var numberOfVisibleDaysforFollowingMonth: Int {
        // Traverse to the last day of the month.
        var parts = baseDate.monthDayAndYearComponents
        
        parts.day = baseDate.numberOfDaysInMonth
        
        // 7*6 = 42 :- 7 columns (7 days in a week) and 6 rows (max 6 weeks in a month)
        return 42 - (numberOfDaysInPreviousPartialWeek + baseDate.numberOfDaysInMonth)
    }
    
    private var calculateCurrentMonthVisibleDays: [Date] {
        let numberOfDaysInMonth = baseDate.numberOfDaysInMonth
        let component = baseDate.monthDayAndYearComponents
        
        return (1...numberOfDaysInMonth).map {
            Date.date(day: $0, month: component.month!, year: component.year!)
        }
    }
    
    private var calculatePreviousMonthVisibleDays: [Date] {
        let date = baseDate.firstDayOfPreviousMonth
        let numberOfDaysInMonth = date.numberOfDaysInMonth
        
        let numberOfVisibleDays = numberOfDaysInPreviousPartialWeek
        let startDay = numberOfDaysInMonth - (numberOfVisibleDays - 1)
        
        if startDay > numberOfDaysInMonth {
            return []
        }
        
        let parts = date.monthDayAndYearComponents
        return (startDay...numberOfDaysInMonth).map {
            Date.date(day: $0, month: parts.month!, year: parts.year!)
        }
    }

    private var calculateFollowingMonthVisibleDays: [Date] {
        
        let date = baseDate.firstDayOfFollowingMonth
        let numberOfDays = numberOfVisibleDaysforFollowingMonth
        let parts = date.monthDayAndYearComponents
        
        return (1...numberOfDays).map {
            Date.date(day: $0, month: parts.month!, year: parts.year!)
        }
    }
    
    private func calculateVisibleDays() {
        currentMonthDays = calculateCurrentMonthVisibleDays
        previousMonthVisibleDays = calculatePreviousMonthVisibleDays
        nextMonthVisibleDays = calculateFollowingMonthVisibleDays
    }
}

extension CalendarLogic: Comparable {
    static func < (lhs: CalendarLogic, rhs: CalendarLogic) -> Bool {
        return (lhs.baseDate.compare(rhs.baseDate) == .orderedAscending)
    }
    
    static func >(lhs: CalendarLogic, rhs: CalendarLogic) -> Bool {
        return (lhs.baseDate.compare(rhs.baseDate) == .orderedDescending)
    }
    
    static func ==(lhs: CalendarLogic, rhs: CalendarLogic) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension CalendarLogic: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(baseDate.hashValue)
    }
}
