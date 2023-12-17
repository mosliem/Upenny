//
//  TransactiosChartProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/21/22.
//

import Charts

protocol TransactionsChartView: AnyObject {
    
    var presenter: TranasactionsChartViewPresenter? {get set}
    func displayChartData(data: BarChartData?)
    func handleXAxisWeekData()
    func handleChartYAxis(yMin: Double, yMax: Double)
    func handleXAxisMonthData(currentMonth: Int)
    func displayTotalSpent(valueString: String)
    func displayDateInterval(dateString: String)
    func reloadTableView()
    func slideToLeftAnimation()
    func slideToRightAnimation()
    func moveToCategoryEntriesDetailsVC(categoryEntries: [CategoryEntryModel]?)
    func chartAnimation()
    func slideToXvalue(_ xValue: Double)
}


protocol TranasactionsChartViewPresenter: class {
    
    init(view: TransactionsChartView)
    var view: TransactionsChartView? {get set}
    
    func viewWillAppear()
    func slideChartLeft()
    func slideChartRight()
    func didChangeSegementValue(index: Int)
    func getCategoriesCount() -> Int
    func configureExpenseCategoryCell(cell: TotalCategoryExpensesCellView, indexPath: Int)
    func didPressCell(indexPath: Int)
    
}
