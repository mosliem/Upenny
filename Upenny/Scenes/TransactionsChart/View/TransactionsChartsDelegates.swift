//
//  ExpensesChartsDelegates.swift
//  Upenny
//
//  Created by mohamedSliem on 8/14/22.
//

import UIKit
import Charts
extension TransactionsChartVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCategoriesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TotalCategoryExpenseTableViewCell.identifier,
            for: indexPath
        ) as! TotalCategoryExpenseTableViewCell
        
        presenter?.configureExpenseCategoryCell(cell: cell, indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.viewStretchAnimatation()
        presenter?.didPressCell(indexPath: indexPath.row)
        
    }
}



extension TransactionsChartVC: TransactionsChartView{
    
    func chartAnimation() {
        barChartView.animate(yAxisDuration: 0.8)
    }
    
    func slideToLeftAnimation() {
        let transition = CATransition()
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromRight
        barChartView.layer.add(transition, forKey: nil)
    }
    
    func slideToRightAnimation() {
        let transition = CATransition()
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromLeft
        barChartView.layer.add(transition, forKey: nil)
    }
    
    
    func displayDateInterval(dateString: String) {
        dateIntervalLabel.text = dateString
    }
    
    func displayTotalSpent(valueString: String) {
        totalSpentLabel.text = valueString
    }
    
    
    
    func reloadTableView(){
        categoryTableView.reloadData()
    }
    
    func handleXAxisMonthData(currentMonth: Int) {
        barChartView.xAxis.axisMinimum = 0.5
        barChartView.xAxis.axisMaximum = 31.8
        barChartView.xAxis.valueFormatter = XAxisMonthData(currentMonth: currentMonth)
        barChartView.xAxis.granularity = 1
        barChartView.setVisibleXRangeMaximum(6)
    }
    
    func displayChartData(data: BarChartData?) {
        
        barChartView.data = data
        barChartView.notifyDataSetChanged()
        barChartView.fitScreen()
    }
    
    func handleXAxisWeekData(){
        barChartView.xAxis.axisMinimum = 0.5
        barChartView.xAxis.axisMaximum = 7.8
        barChartView.xAxis.valueFormatter = XAxisWeekData()
        barChartView.xAxis.granularity = 1
        barChartView.setVisibleXRangeMaximum(7.8)
    }
    
    func handleChartYAxis(yMin: Double, yMax: Double){
        barChartView.rightAxis.axisMaximum = yMax
        barChartView.rightAxis.axisMinimum = yMin
        barChartView.rightAxis.setLabelCount(3, force: true)
    }
    
    func moveToCategoryEntriesDetailsVC(categoryEntries: [CategoryEntryModel]?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CategoryExpensesDetailsVC") as! CategoryExpensesDetailsVC
        vc.categoryEntries = categoryEntries
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

