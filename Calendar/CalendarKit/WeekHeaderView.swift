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
    let formatter = DateFormatter()
    
    override func awakeFromNib() {
        if labels.count == formatter.weekdaySymbols.count {
            let weekdaySymbols = formatter.weekdaySymbols!
            (0..<weekdaySymbols.count).forEach { index in
                labels[index].text = String(weekdaySymbols[index].prefix(3)).uppercased()
            }
        }
    }
    
}
