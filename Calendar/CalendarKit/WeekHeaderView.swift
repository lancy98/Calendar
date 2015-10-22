//
//  WeekHeaderView.swift
//  Calendar
//
//  Created by Lancy on 02/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import UIKit

class WeekHeaderView: UICollectionReusableView {

    @IBOutlet var labels: [UILabel]!
    
    let formatter = NSDateFormatter()
    
    override func awakeFromNib() {
        if labels.count == formatter.weekdaySymbols.count {
            for var i = 0; i < formatter.weekdaySymbols.count; i++ {
                let weekDayString = formatter.weekdaySymbols[i] 
                
                labels[i].text = weekDayString.substringToIndex(weekDayString.startIndex.advancedBy(3)).uppercaseString
            }
        }
    }
    
}
