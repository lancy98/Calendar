//
//  ViewController.swift
//  Calendar
//
//  Created by Lancy on 01/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalendarViewDelegate {
    
    @IBOutlet var placeholderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // todays date.
        let date = Date()
        
        // create an instance of calendar view with 
        // base date (Calendar shows 12 months range from current base date)
        // selected date (marked dated in the calendar)
        let calendarView = CalendarView.instance(baseDate: date, selectedDate: date)
        calendarView.delegate = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.addSubview(calendarView)
        
        // Constraints for calendar view - Fill the parent view.
        placeholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[calendarView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["calendarView": calendarView]))
        placeholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[calendarView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["calendarView": calendarView]))
    }
    
    func didSelectDate(date: Date) {
        print("\(date.year)-\(date.month)-\(date.day)")
    }
}

