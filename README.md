# iOS calendar component writtern in swift  
[![Build Status](https://travis-ci.com/lancy98/Calendar.svg?branch=master)](https://travis-ci.com/lancy98/Calendar)

Usage
========
1. Drag the `CalendarKit`folder into your project. You will find this folder inside `Calendar`.
2. You can add the calendar to a placeholder view, so create an outlet for it.
<pre lang="Swift">
@IBOutlet var placeholderView: UIView!
</pre>
3. Your `viewDidLoad` method in the `Viewcontroller` should look like
<pre lang="Swift">
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
</pre>
4. Implement the delegate method
<pre lang="Swift">
func didSelectDate(date: Date) {
    println("\(date.year)-\(date.month)-\(date.day)")
}
</pre>
Make sure your `Viewcontroller` class conforms to `CalendarViewDelegate` protocol.

Screenshot
========
<center><img src="https://github.com/lancy98/Calendar/blob/master/etc/screenshot.png" width=320></center>

License
========
The MIT License (MIT)

Copyright (c) 2015 Lancy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
