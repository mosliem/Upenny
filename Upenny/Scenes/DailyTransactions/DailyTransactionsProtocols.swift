//
//  DailyExpensesProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/16/22.
//

import Foundation


protocol DailyTransactionView : class{
    
    var presenter: DailyTransactionsVCPresenter? { get set }

    func setBalanceValue(value: String)
    func setIncomeValue(value: String)
    func setExpenseValue(value: String)
    func reloadData()
    func showActionAlert(title: String, alertMessage: String)
    func showNoTransactionsLabel()
    func hideNoTransactionsLabel()
    func moveToTransactionDetailsVC(selectedTransaction: CategoryEntryModel)
    func displayErrorAlert(title: String, message: String, actionName: String)
    func moveToAccountHistoryVC()
    func balanceViewAnimation()

}

protocol DailyTransactionViewPresenter: class {
    
    var view: DailyTransactionView? {get set}
    
    init(view: DailyTransactionView)
    func viewWillAppear()
    func configureCell(cell: DailyTransactionViewCell, section: Int, indexPath: Int)
    func didTapCell(section: Int, indexPath: Int)
    func getTransactionsPerSection(section: Int) -> Int
    func getNumberOfSections() -> Int
    func heightForSection(section: Int) -> Int
    func dateStringForSectionHeader(section: Int) -> String
    func totalTransactionValueForSection(section: Int) -> String
    func deleteCellAtIndex(section: Int, indexPath: Int)
    func yesDeleteAlertPressed()
    func balanceViewPressed()
   
}
