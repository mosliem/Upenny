//
//  ChartsHelper.swift
//  Upenny
//
//  Created by mohamedSliem on 8/21/22.
//

import Charts

class ChartsHelper {
    
    static func configureBarChartWeekData(weekTransactions: [[CategoryEntryModel]], completion: @escaping(BarChartData) -> Void){
       
        var i = 1
        // data set with its characteristics

        let dataSet = BarChartDataSet()
        dataSet.drawValuesEnabled = false
        dataSet.setColor(UIColor.black.withAlphaComponent(0.8))
        dataSet.barShadowColor = .systemGray6
        dataSet.highlightEnabled = false
        
        for day in weekTransactions.reversed(){
            
            guard !day.isEmpty else {
                continue
            }
            
            let total = day.map{$0.cost}.reduce(0, +)
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(total))
            dataSet.append(dataEntry)
          
            i += 1
        }
        
        // bar chart data with bar characteristics
        
        let barChartData = BarChartData(dataSet: dataSet)
        barChartData.barWidth = Double(0.6)
        
        completion(barChartData)
    }
    
    
    static func configureBarChartMonthData(monthTransactions: [[CategoryEntryModel]], completion: @escaping(BarChartData, Int) -> Void){
        
        // data set with its characteristics

        let dataSet = BarChartDataSet()
        dataSet.drawValuesEnabled = false
        dataSet.setColor(UIColor.black.withAlphaComponent(0.8))
        dataSet.barShadowColor = .systemGray6
        dataSet.highlightEnabled = false
        
  
        
        for day in monthTransactions.reversed(){
            
            guard !day.isEmpty else {
                continue
            }
            
            let total = day.map{$0.cost}.reduce(0, +)
            let dataEntry = BarChartDataEntry(x: Double(Int(day[0].date.dayOfDate)), y: Double(total))
            dataSet.append(dataEntry)
        }
        
        let barChartData = BarChartData(dataSet: dataSet)
        barChartData.barWidth = Double(0.6)
        
        completion(barChartData, (monthTransactions[0].first?.date.monthOfDate) ?? 1)
        
    }
}
