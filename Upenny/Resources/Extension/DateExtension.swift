//
//  DateExtension.swift
//  Upenny
//
//  Created by mohamedSliem on 8/18/22.
//

import Foundation

extension Date{
    
    var startOfWeekDate: Date {
        
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.firstWeekday = 7
        
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return Date()
        }
        
        return startDay
    }
    
    var endOfWeekDate: Date{
        return self.addingTimeInterval(604800)
    }
    
    func getTodayName(date: Date) -> String {
           
           let date = Date()
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEE"
           let dayInWeek = dateFormatter.string(from: date)
           return dayInWeek
       }
       
       var startOfMonth: Date {
           
           let calendar = Calendar(identifier: .gregorian)
           let components = calendar.dateComponents([.year, .month], from: self)
           return  calendar.date(from: components)!
           
       }
       
       var endOfMonth: Date {
           
           let calender = Calendar(identifier: .gregorian)
           var dateCompenent = DateComponents()
           dateCompenent.month = 1
           dateCompenent.day = -1
           
           let endMonth = calender.date(byAdding: dateCompenent, to: startOfMonth)!
           return endMonth
       }
    
    var timeFromDate: String? {
        
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+02")
        
        return dateFormatter.string(from: self)
    }
    
    var fullDateString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        return dateFormatter.string(from: self)
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: self)
    }
    
    var longDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE , d MMM y"
        return dateFormatter.string(from: self)
    }

    var dayIndex: Int? {
        
        var calender = Calendar(identifier: .gregorian)
        calender.firstWeekday = 7
        let dayNumber = calender.dateComponents([.weekday], from: self)
        return dayNumber.weekday
    }
    
    var startOfDay: Date {
        let startOfDay = Calendar(identifier: .gregorian).startOfDay(for: self)
        return startOfDay
    }
    
    var dayOfDate: Int{
        
        let calender = Calendar(identifier: .gregorian).dateComponents([.day], from: self)
        return calender.day!
    }
    
    var monthOfDate: Int{
        let calender = Calendar(identifier: .gregorian).dateComponents([.month], from: self)
        return calender.month!
    }
}

extension Calendar {
    
    static func numberOfDaysBetween(_ from: Date, _ to: Date) -> Int{
        
        let calendar = Calendar(identifier: .gregorian)
        let fromDay = calendar.startOfDay(for: from)
        let toDay = calendar.startOfDay(for: to)
        let numberOfDays = calendar.dateComponents([.day], from: fromDay, to: toDay)
        return numberOfDays.day! + 1
    }
}
