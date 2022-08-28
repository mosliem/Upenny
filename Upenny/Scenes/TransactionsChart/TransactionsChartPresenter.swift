//
//  TransactionsVCPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/21/22.

import Foundation

class TransactionsChartPresenter: TranasactionsChartViewPresenter {
   
    weak var view: TransactionsChartView?
    private var chartWeekData = [[CategoryEntryModel]]()
    private var chartMonthData = [[CategoryEntryModel]]()
    private var expensesCategories = [String: [CategoryEntryModel]]()
    private var expensesCategoriesIndexes = [String]()
    
    private var selectedIndexType: IndexType = .Week
    private var currentStartDate: Date = Date()
    private var currentEndDate : Date = Date().startOfWeekDate
    
    private var totalExpenses: Float = 0
    
    required init(view: TransactionsChartView) {
        self.view = view
    }
    
    func viewWillAppear() {
        updateCurrentDate()
        dateInterval()
        getExpensesChartData()
        getExpensesCategoriesData()
        totalExpensesValue()
    }
    
    func getViewsData(){
        
        getExpensesChartData()
        getExpensesCategoriesData()
        dateInterval()
        totalExpensesValue()
    }
    
    func slideChartLeft() {
        
        var changeValue = 0.0
        switch selectedIndexType {
        
        case .Week:
            changeValue = 604800
        case .Month:
            changeValue = 1
        }
        
        updateCurrentDate(changeValue: changeValue)
        getViewsData()
        view?.slideToLeftAnimation()
    }
    
    func slideChartRight() {
        var changeValue = 0.0
        switch selectedIndexType {
        
        case .Week:
            changeValue = -86400
        case .Month:
            changeValue = -1
        }
        
        updateCurrentDate(changeValue: changeValue)
        getViewsData()
        view?.slideToRightAnimation()
        
    }
    
    func getCategoriesCount() -> Int{
        return expensesCategoriesIndexes.count
    }
    
    func didPressCell(indexPath: Int) {
        
        let indexKey = expensesCategoriesIndexes[indexPath]
        let categoryEntries = expensesCategories[indexKey]
        view?.moveToCategoryEntriesDetailsVC(categoryEntries: categoryEntries)
    }
    
    
    func configureExpenseCategoryCell(cell: TotalCategoryExpensesCellView, indexPath: Int){
        
        let indexKey = expensesCategoriesIndexes[indexPath]
        let categoryEntries = expensesCategories[indexKey]
        
        let categoryName = categoryEntries?.first?.categoryName ?? ""
        let categoryTotalExpenses = categoryEntries?.map{$0.cost}.reduce(0, +) ?? 0
        let entriesCount = String(categoryEntries?.count ?? 0) + " entries"
        let categoryIconString = categoryEntries?.first?.iconName
        
        let categoryExpensePrecentage = ((categoryTotalExpenses / totalExpenses ) * 100).rounded()
        
        if categoryExpensePrecentage >= 25{
            cell.displayWarningPrecentageValue(value: String(categoryExpensePrecentage.ZeroDots) + "%")
        }
        else{
            cell.displayPrecentageValue(value: String(categoryExpensePrecentage.ZeroDots) + "%")
        }
        
        cell.displayCategoryEntriesNumber(number: entriesCount)
        cell.displayCategoryName(categoryName: categoryName)
        cell.displayExpenseTotalValue(value: "$" + categoryTotalExpenses.ZeroDots)
        cell.displayCategoryIcon(categoryIconString: categoryIconString)
        
    }
    
    func didChangeSegementValue(index: Int){
        
        let type = IndexType.indexToEnum(index)
        selectedIndexType = type
        resetCurrentDate()
        getViewsData()
        
    }
  
    //MARK:- Private functions
    private func dateInterval(){
        
        let startDayDate = currentStartDate.dayOfDate
        let endDayDate = currentEndDate.dateString
        
        let dateIntervalString = "Total spent from \(startDayDate) - \(endDayDate)"
        view?.displayDateInterval(dateString: dateIntervalString)
    }
    
    private func totalExpensesValue(){
        
        var totalExpenses: Float = 0
        
        for key in expensesCategoriesIndexes{
            
            let category = expensesCategories[key]
            totalExpenses += category?.map{$0.cost}.reduce(0, +) ?? 0
        }
        
        self.totalExpenses = totalExpenses
        view?.displayTotalSpent(valueString: "$"+totalExpenses.ZeroDots)
    }
    
    private func updateCurrentDate(changeValue: Double? = 0){
        
        switch selectedIndexType {
        
        case .Week:
            self.currentStartDate = currentStartDate.addingTimeInterval(changeValue!).startOfWeekDate
            self.currentEndDate = currentStartDate.endOfWeekDate
            
        case .Month:
            currentStartDate = Calendar.current.date(byAdding: .month, value: Int(changeValue!), to: currentStartDate)?.startOfMonth ?? Date()
            currentEndDate = currentStartDate.endOfMonth
            
        }
    }
    
    private func resetCurrentDate(){
        
        switch selectedIndexType {
        
        case .Week:
            self.currentStartDate = Date().startOfWeekDate
            self.currentEndDate = currentStartDate.endOfWeekDate
            
        case .Month:
            currentStartDate = Date().startOfMonth
            currentEndDate = currentStartDate.endOfMonth
            
        }
        
    }
    
    private func getExpensesCategoriesData(){
        
        RealmManger.shared.getExpenseTransactionsBetweenDates(from: currentStartDate, to: currentEndDate) { [weak self] (expensesCategories, expensesCategoriesIndexes)  in
            
            self?.expensesCategories = expensesCategories
            self?.expensesCategoriesIndexes = expensesCategoriesIndexes
            self?.view?.reloadTableView()
        }
    }
    
    private func getExpensesChartData(){
        
        RealmManger.shared.getIndexedExpenseTransactionsBetweenDates(from: currentStartDate, to: currentEndDate, indexType: selectedIndexType) {[weak self] (result) in
            
            switch self!.selectedIndexType{
            case .Week:
                self?.chartWeekData = result
                self?.configureWeekChartData(data: result)
                
                
            case .Month:
                self?.chartMonthData = result
                self?.configureMonthChartData(data: result)
            }
        }
        
    }
    
    private func configureWeekChartData(data: [[CategoryEntryModel]]){
        
        guard !Array.is2dEmpty(array: data) else {
            
            view?.displayChartData(data: nil)
            return
        }
        
        
        ChartsHelper.configureBarChartWeekData(weekTransactions: data) { [weak self](barChartData) in
            self?.view?.chartAnimation()
            self?.hanldeYMinMax(barChartData.yMin, barChartData.yMax)
            self?.view?.displayChartData(data: barChartData)
            self?.view?.handleXAxisWeekData()
        }
    }
    
    private func configureMonthChartData(data: [[CategoryEntryModel]]){
        
        guard !Array.is2dEmpty(array: data) else {
            
            view?.displayChartData(data: nil)
            return
        }
        
        ChartsHelper.configureBarChartMonthData(monthTransactions: data) { [weak self] (barChartData, currentMonth)  in
            self?.view?.chartAnimation()
            self?.hanldeYMinMax(barChartData.yMin, barChartData.yMax)
            self?.view?.displayChartData(data: barChartData)
            self?.view?.handleXAxisMonthData(currentMonth: currentMonth)
        }
    }
    
    private func hanldeYMinMax( _ yMin: Double,_ yMax: Double){
        
        let yMin = yMin
        var yMax = yMax
        if yMax == yMin {
            yMax = yMin * 2
        }
        
        self.view?.handleChartYAxis(yMin: yMin, yMax: yMax)
    }
    
}
