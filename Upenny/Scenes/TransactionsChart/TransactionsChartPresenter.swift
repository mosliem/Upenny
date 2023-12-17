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
    private var expensesCategoryExpensesTotal = [String : Float]()
    
    private var selectedIndexType: IndexType = .Week
    
    private var currentStartDate: Date = Date()
    private var currentEndDate : Date = Date().startOfWeekDate
    
    private var totalExpenses: Float = 0
    
    required init(view: TransactionsChartView) {
        self.view = view
    }
    
    func viewWillAppear() {
        updateCurrentDate()
        getViewsData()
    }
    
    func getViewsData(){
        
        DispatchQueue.global().sync {
            getExpensesChartData()
            getExpensesCategoriesData()
            dateInterval()
            sortCategoriesExpensesTotal()
        }
        
        // its result is consequent to the process of calculating total expenses by category
        totalExpensesValue()
        view?.reloadTableView()
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
    
    private func sortCategoriesExpensesTotal(){
        
        expensesCategoryExpensesTotal.removeAll()
        
        for category in expensesCategories {
            expensesCategoryExpensesTotal[category.key] = category.value.map({$0.cost}).reduce(0, +)
        }
        
        expensesCategoriesIndexes = expensesCategoryExpensesTotal.sorted(by: {$0.value > $1.value}).map({$0.key})
    }
    
    
  
    
    private func dateInterval(){
        
        let startDayDate = currentStartDate.dayOfDate
        let endDayDate = currentEndDate.dateString
        
        let dateIntervalString = "Total spent from \(startDayDate) - \(endDayDate)"
        view?.displayDateInterval(dateString: dateIntervalString)
    }
    
    private func totalExpensesValue(){
        
        self.totalExpenses = expensesCategoryExpensesTotal.map({$0.value}).reduce(0, +)
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
        
        RealmManger.shared.getExpenseTransactionsBetweenDates(from: currentStartDate, to: currentEndDate) { [weak self] (expensesCategories)  in
            
            self?.expensesCategories = expensesCategories
            
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
            self?.handleYMinMax(barChartData.yMin, barChartData.yMax)
            self?.view?.displayChartData(data: barChartData)
            self?.view?.handleXAxisWeekData()
        }
    }
    
    private func configureMonthChartData(data: [[CategoryEntryModel]]){
        
        guard !Array.is2dEmpty(array: data) else {
            
            view?.displayChartData(data: nil)
            return
        }
        
        let currentDayOfMonth = Date().dayOfDate
        
        ChartsHelper.configureBarChartMonthData(monthTransactions: data) { [weak self] (barChartData, currentMonth)  in
            
            self?.view?.chartAnimation()
            self?.handleYMinMax(barChartData.yMin, barChartData.yMax)
            self?.view?.displayChartData(data: barChartData)
            self?.view?.handleXAxisMonthData(currentMonth: currentMonth)
            
            self?.view?.slideToXvalue(Double(currentDayOfMonth))
        }
    }
    
    private func handleYMinMax( _ yMin: Double,_ yMax: Double) {
        
        var yMin = yMin
        var yMax = yMax
        
        if yMax == yMin {
            yMax = yMin * 2
            yMin = yMin / 2
        }
        
        self.view?.handleChartYAxis(yMin: yMin, yMax: yMax)
    }
    
    
}
