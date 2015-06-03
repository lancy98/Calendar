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
        
        let date = NSDate()
        
        let calendarView = CalendarView.instance(date, selectedDate: date)
        calendarView.delegate = self
        calendarView.setTranslatesAutoresizingMaskIntoConstraints(false)
        placeholderView.addSubview(calendarView)
        
        // Constraints for calendar view - Fill the parent view.
        placeholderView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[calendarView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["calendarView": calendarView]))
        placeholderView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[calendarView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["calendarView": calendarView]))
    }
    
    func didSelectDate(date: NSDate) {
        println("\(date.year)-\(date.month)-\(date.day)")
    }
}

