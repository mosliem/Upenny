//
//  DailyExpensesPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/10/22.
//

import Foundation


class DailyTransactionsVCPresenter: DailyTransactionViewPresenter{
   
    weak var view: DailyTransactionView?
    var accountBalance: AccountBalanceModel?
    var weeklyTransaction = [[CategoryEntryModel]]()
    var selectedTransactionIndex = 0
    var selectedSection = 0
    
    
    required init(view: DailyTransactionView) {
        self.view = view
    }
    
    func viewWillAppear() {
        
        getAccountBalance()
        getCurrentWeekTransactions()
        
    }
    
    func getTransactionsPerSection(section: Int) -> Int {
        return weeklyTransaction[section].count
    }
    
    
    func didTapCell(section: Int, indexPath: Int) {
        let transaction = weeklyTransaction[section][indexPath]
        view?.moveToTransactionDetailsVC(selectedTransaction: transaction)
    }
    
    func configureCell(cell: DailyTransactionViewCell, section: Int, indexPath: Int) {
        
        let cellIndex = weeklyTransaction[section][indexPath]
        
        let name = cellIndex.categoryName
        let iconName = cellIndex.iconName
        let cost = cellIndex.cost.ZeroDots
        let time = cellIndex.date.timeFromDate
        
        cell.displayCategoryIcon(categoryIconName: iconName)
        cell.displayCategoryName(categoryName: name)
        cell.displayTransactionTime(timeString: time)
        
        switch cellIndex.typeEnum {
        
        case .expense:
            cell.displayExpenseValue(value: "-$" + cost)
        case .income:
            cell.displayIncomeValue(value: "+$" + cost)
            
        }
    }
    
    private func getAccountBalance(){
        
        RealmManger.shared.getAccountBalance(completion: { result in
            self.accountBalance = result
            self.setAccountBalanceValues(balance: self.accountBalance!)
            
        })
    }
    
    
    private func getCurrentWeekTransactions(){
        
        let startDate = Date().startOfWeekDate
        let currentDate = Date()
        
        
        RealmManger.shared.getTransationsBetweenDates(from: startDate, to: currentDate) { (result) in
            
            guard !Array.is2dEmpty(array: result) else {
                self.view?.showNoTransactionsLabel()
                return
            }
            self.view?.hideNoTransactionsLabel()
            self.weeklyTransaction = result
            self.view?.reloadData()
        }
    }
    
    private func setAccountBalanceValues(balance: AccountBalanceModel){
        
        view?.setBalanceValue(value: "$ " + balance.currentBalance.ZeroDots)
        view?.setIncomeValue(value: "$ " + balance.currentTotalIncome.ZeroDots)
        view?.setExpenseValue(value:"$ " + balance.currentTotalExpense.ZeroDots)
        
    }
    
    
    
    func getNumberOfSections() -> Int {
        return weeklyTransaction.count
    }
    
    func heightForSection(section: Int) -> Int{
        
        if weeklyTransaction[section].isEmpty{
            return 0
        }
        else {
            return 50
        }
    }
    
    func dateStringForSectionHeader(section: Int) -> String {
        
        let dateString = weeklyTransaction[section].first?.date
        
        if Date().fullDateString == dateString?.fullDateString {
            return "Today"
        }
        
        return dateString!.dateString
    }
    
    func totalTransactionValueForSection(section: Int) -> String {
        var count : Float = 0
        count = weeklyTransaction[section].map({$0.cost}).reduce(0, +)
        return "$"+count.ZeroDots 
    }
    
    func deleteCellAtIndex(section: Int, indexPath: Int){
        view?.showActionAlert(title: "Warning", alertMessage: "Are you sure you want to delete this transaction?")
        selectedTransactionIndex = indexPath
        selectedSection = section
    }
    
    func yesDeleteAlertPressed() {
        
        let selectedTransaction = weeklyTransaction[selectedSection][selectedTransactionIndex]
        let transactionDate = selectedTransaction.date
        let transactionType = selectedTransaction.typeEnum
        
        RealmManger.shared.deleteTransactionWithDate(date: transactionDate, transactionType: transactionType) { (result) in
            
            switch result {
            
            case .success:
                self.getCurrentWeekTransactions()
                self.getAccountBalance()
                
            case .failure(let error):
                let error = (error as! RealmError).message
                self.view?.displayErrorAlert(title: "Error", message: error, actionName: "OK")
            }
        }
    }
    
    func balanceViewPressed() {
        view?.balanceViewAnimation()
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.view?.moveToAccountHistoryVC()
        }
    }
    
}


