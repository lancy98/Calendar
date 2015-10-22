//
//  MonthCollectionCell.swift
//  Calendar
//
//  Created by Lancy on 02/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import UIKit

protocol MonthCollectionCellDelegate: class {
    func didSelect(date: Date)
}

class MonthCollectionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    weak var monthCellDelgate: MonthCollectionCellDelegate?
    
    var dates = [Date]()
    var previousMonthVisibleDatesCount = 0
    var currentMonthVisibleDatesCount = 0
    var nextMonthVisibleDatesCount = 0

    var logic: CalendarLogic? {
        didSet {
            populateDates()
            if collectionView != nil {
                collectionView.reloadData()
            }
        }
    }
    
    var selectedDate: Date? {
        didSet {
            if collectionView != nil {
                collectionView.reloadData()
            }
        }
    }
    
    func populateDates() {
        if logic != nil {
            dates = [Date]()
            
            dates += logic!.previousMonthVisibleDays!
            dates += logic!.currentMonthDays!
            dates += logic!.nextMonthVisibleDays!
            
            previousMonthVisibleDatesCount = logic!.previousMonthVisibleDays!.count
            currentMonthVisibleDatesCount = logic!.currentMonthDays!.count
            nextMonthVisibleDatesCount = logic!.nextMonthVisibleDays!.count
            
        } else {
            dates.removeAll(keepCapacity: false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "DayCollectionCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "DayCollectionCell")
        
        let headerNib = UINib(nibName: "WeekHeaderView", bundle: nil)
        self.collectionView.registerNib(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekHeaderView")
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 7*6 = 42 :- 7 columns (7 days in a week) and 6 rows (max 6 weeks in a month)
        return 42
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DayCollectionCell", forIndexPath: indexPath) as! DayCollectionCell
        
        let date = dates[indexPath.item]
        
        cell.date = (indexPath.item < dates.count) ? date : nil
        cell.mark = (selectedDate == date)
        
        cell.disabled = (indexPath.item < previousMonthVisibleDatesCount) ||
                        (indexPath.item >= previousMonthVisibleDatesCount
                            + currentMonthVisibleDatesCount)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if monthCellDelgate != nil {
            monthCellDelgate!.didSelect(dates[indexPath.item])
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekHeaderView", forIndexPath: indexPath) 
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width/7.0, collectionView.frame.height/7.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(collectionView.frame.width, collectionView.frame.height/7.0)
    }
}
