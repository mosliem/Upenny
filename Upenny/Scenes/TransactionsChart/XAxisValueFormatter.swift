//
//  XAxisValueFormatter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/21/22.
//

import UIKit
import Charts

enum days: Int{
    case Sat = 1
    case Sun = 2
    case Mon = 3
    case TUE = 4
    case Wed = 5
    case THU = 6
    case Fri = 7
    
    var label: String{
        switch self {
        
        case .Sat:
            return "Sat"
        case .Sun:
            return "Sun"
        case .Mon:
            return "Mon"
        case .TUE:
            return "Tue"
        case .Wed:
            return "Wed"
        case .THU:
            return "Thu"
        case .Fri:
            return "Fri"
        }
    }
}


enum Months: Int{
     case Jan = 1
     case Feb = 2
     case Mar = 3
     case Apr = 4
     case May = 5
     case Jun = 6
     case Jul = 7
     case Aug = 8
     case Sept = 9
     case Oct = 10
     case Nov = 11
     case Dec = 12
    
    var label: String{
        switch self {
      
        case .Jan:
            return "Jan"
        case .Feb:
            return "Feb"
        case .Mar:
            return "Mar"
        case .Apr:
            return "Apr"
        case .May:
            return "May"
        case .Jun:
            return "Jun"
        case .Jul:
            return "Jul"
        case .Aug:
            return "Aug"
        case .Sept:
            return "Sept"
        case .Oct:
            return "Oct"
        case .Nov:
            return "Nov"
        case .Dec:
            return "Dec"
        }
    }
}

final class XAxisWeekData: AxisValueFormatter{
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let intVal = Int(value)
        let daysLabel = days(rawValue: intVal)
        return daysLabel?.label ?? ""
    }
    
    
}


final class XAxisMonthData: AxisValueFormatter{
    
    var currentMonth: Int?
   
    convenience init(currentMonth: Int){
        self.init()
        self.currentMonth = currentMonth
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        guard  let currentMonth = currentMonth else {
            return ""
        }
        
        return String(Int(value)) + Months(rawValue: currentMonth)!.label
    
    }
    
}
