//
//  CalendarView.swift
//  Calendar
//
//  Created by Lancy on 02/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import UIKit

// 12 months - base date - 12 months
let kMonthRange = 12

protocol CalendarViewDelegate: class {
    func didSelectDate(date: Date)
}

class CalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, MonthCollectionCellDelegate {
    
    @IBOutlet var monthYearLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    weak var delegate: CalendarViewDelegate?
    
    private var collectionData = [CalendarLogic]()
    var baseDate: Date? {
        didSet {
            collectionData = [CalendarLogic]()
            if let date = baseDate {
                var dateIter1 = date, dateIter2 = date
                
                var set = Set<CalendarLogic>()
                set.insert(CalendarLogic(date: baseDate!))
                
                // advance one year
                (0..<kMonthRange).forEach { _ in
                    dateIter1 = dateIter1.firstDayOfFollowingMonth
                    dateIter2 = dateIter2.firstDayOfPreviousMonth
                    
                    set.insert(CalendarLogic(date: dateIter1))
                    set.insert(CalendarLogic(date: dateIter2))
                }
                
                collectionData = Array(set).sorted(by: <)
            }
            
            updateHeader()
            collectionView.reloadData()
        }
    }
    
    var selectedDate: Date? {
        didSet {
            collectionView.reloadData()
            DispatchQueue.main.async {
                self.moveToSelectedDate(animated: false)
                if self.delegate != nil {
                    self.delegate!.didSelectDate(date: self.selectedDate!)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        let nib = UINib(nibName: "MonthCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MonthCollectionCell")
    }
    
    class func instance(baseDate: Date, selectedDate: Date) -> CalendarView {
        let calendarView = Bundle.main.loadNibNamed("CalendarView", owner: nil, options: nil)!.first as! CalendarView
        calendarView.selectedDate = selectedDate
        calendarView.baseDate = baseDate
        return calendarView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MonthCollectionCell",
            for: indexPath) as! MonthCollectionCell
        
        cell.monthCellDelgate = self
        
        cell.logic = collectionData[indexPath.item]
        if cell.logic!.isVisible(date: selectedDate!) {
            cell.selectedDate = selectedDate!
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            updateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateHeader()
    }
    
    func updateHeader() {
        let pageNumber = Int(collectionView.contentOffset.x / collectionView.frame.width)
        updateHeader(pageNumber: pageNumber)
    }
    
    func updateHeader(pageNumber: Int) {
        if collectionData.count > pageNumber {
            let logic = collectionData[pageNumber]
            monthYearLabel.text = logic.currentMonthAndYear as String
        }
    }
    
    @IBAction func retreatToPreviousMonth(button: UIButton) {
        advance(byIndex: -1, animate: true)
    }
    
    @IBAction func advanceToFollowingMonth(button: UIButton) {
        advance(byIndex: 1, animate: true)
    }
    
    func advance(byIndex: Int, animate: Bool) {
        var visibleIndexPath = self.collectionView.indexPathsForVisibleItems.first!
        
        if (visibleIndexPath.item == 0 && byIndex == -1) ||
            ((visibleIndexPath.item + 1) == collectionView.numberOfItems(inSection: 0) && byIndex == 1) {
            return
        }
        
        visibleIndexPath = IndexPath(item: visibleIndexPath.item + byIndex,
                                     section: visibleIndexPath.section)
        
        updateHeader(pageNumber: visibleIndexPath.item)
        collectionView.scrollToItem(at: visibleIndexPath,
                                    at: .centeredHorizontally,
                                    animated: animate)
    }
    
    func moveToSelectedDate(animated: Bool) {
        let index = (0..<collectionData.count).firstIndex { index -> Bool in
            let logic = collectionData[index]
            if logic.containsDate(date: selectedDate!) {
                return true
            }
            return false
        }
        
        if let index = index {
            let indexPath = IndexPath(item: index, section: 0)
            updateHeader(pageNumber: indexPath.item)
            collectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: animated)
        }
    }
    
    //MARK: Month cell delegate.
    func didSelect(date: Date) {
        selectedDate = date
    }
}
