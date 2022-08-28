//
//  AccountHistoryVCPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/27/22.
//

import Foundation

class AccountHistoryVCPresenter: AccountHistoryViewPresenter {
    
    
    weak var view: AccountHistoryView?
    private var selectedFilterType: AccountHistoryFilterType = .all
    private var accountHistory = [AccountHistoryModel]()
    private var filteredAccountHistory = [AccountHistoryModel]()
    
    required init(view: AccountHistoryView) {
        self.view = view
    }
    
    
    func viewDidLoad() {
        self.getAccountHistory()
        filterAccountHistory()
    }
    
    
    func getAccountHistoryCount() -> Int {
        return filteredAccountHistory.count
    }
    
    func filterSegementPressed(type: AccountHistoryFilterType) {
        self.selectedFilterType = type
        filterAccountHistory()
    }
    
    func backPressed() {
        view?.moveToMain()
    }
    
    
    func configureCell(cell: AccountHistoryViewCell, indexPath: Int){
        
        let cellIndex = filteredAccountHistory[indexPath]
        
        switch cellIndex.typeEnum {
        
        case .expense:
            cell.displayExpenseLabel()
            cell.displayExpenseImageView()
            
        case .income:
            cell.displayIncomeLabel()
            cell.displayIncomeImageView()
        }
        
        let value = "$" + cellIndex.value.ZeroDots
        cell.displayTransactionValue(value: value)
        
        let date = cellIndex.date.longDateString
        cell.displayTransactionDate(dateString: date)
    }
    
    private func getAccountHistory(){
        RealmManger.shared.getAccountHistory {[weak self] (result) in
            self?.accountHistory = result
        }
    }
    
    private func filterAccountHistory(){
        
        switch selectedFilterType {
        
        case .all:
            filteredAccountHistory = accountHistory
        case .income:
            filteredAccountHistory = accountHistory.filter{$0.transactionType == "income"}
        case .expense:
            filteredAccountHistory = accountHistory.filter{$0.transactionType == "expense"}
        }
        
        guard !filteredAccountHistory.isEmpty else{
            view?.viewNoAccountHistoryLabel()
            return
        }
        view?.hideNoAccountHistoryLabel()
        view?.reloadTableView()
    }
    
    
    
}
