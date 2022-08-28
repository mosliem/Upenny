//
//  AddExpensesProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import Foundation

enum TransactionField: String , CaseIterable {
    case moneyAmount
    case categoryName
   
    static func typeFromString(string: String) -> TransactionField {
        return self.allCases.first{"\($0)" == string}! 
    }
}

protocol AddTransactionView: class {
    
    var presenter: AddTransactionViewPresenter?  { get set }

    func updateCategoryTextFieldFrame()
    func updateMoneyAmountTextFieldFrame()
    func backToMain()
    func animateSaveButton()
    func moveToAddNoteVC()
    func getCategoryName() -> String?
    func getCategoryCost() -> String?
    func showBalanceAmountErrorLabel(_ errorMessage: String)
    func hideBalanceAmountErrorLabel()
    func showErrorAlert(errorMessage: String)
    func setTransactionTime(time: String)
    
}

protocol AddTransactionViewPresenter: class{
    
    var view: AddTransactionView? { get set }
    init(view: AddTransactionView)
    
    func viewDidLoad()
    
    func textDidChanaged(transactionField: TransactionField, text: String?)
    func textShouldChanage(_ placeholder: String?, text: String?, range: NSRange, replacementString: String, fieldType: TransactionField) -> Bool
    
    func expenseIncomeSegmentPressed(index: Int)
    func savePressed()
    func addNotePressed()
    func backToMainPressed()
    func updateCategoryIcon(iconString: String?)
    func finishNote(note: String?)
 
}
