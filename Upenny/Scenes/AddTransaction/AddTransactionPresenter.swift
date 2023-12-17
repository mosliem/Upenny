//
//  AddExpensesVCPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import Foundation


class AddTransactionPresenter: AddTransactionViewPresenter {
    
    
    weak var view: AddTransactionView?
    private var category = CategoryEntryModel()
    private var accountBalance: AccountBalanceModel?
    private var acceptedProcess: Bool = false
    
    required init(view: AddTransactionView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getAccountBalance()
        setTransactionTime()
    }
    
    private func getAccountBalance(){
        
        RealmManger.shared.getAccountBalance { (result) in
            self.accountBalance = result
        }
        
    }
    
    private func setTransactionTime(){
        let time = "today at " + Date().timeFromDate!
        view?.setTransactionTime(time: time)
    }
    
    func textDidChanaged(transactionField: TransactionField, text: String?){
        
        switch transactionField {
        
        case .moneyAmount:
            view?.updateMoneyAmountTextFieldFrame()
            checkBalanceAmount(value: text)
            updateMoneyAmount(value: text)
            
        case .categoryName:
            view?.updateCategoryTextFieldFrame()
            updateCategoryName(name: text)
            
        }
        
    }
    
    func textShouldChanage(_ placeholder: String?, text: String?, range: NSRange, replacementString: String, fieldType: TransactionField) -> Bool{
        
        switch fieldType {
        
        case .moneyAmount:
            
            guard let text = text, let rangeOfTextToReplace = Range(range, in: text) else{
                
                return false
            }
            
            let substringToReplace = text[rangeOfTextToReplace]
            let count = text.count - substringToReplace.count + replacementString.count
            
            return count <= 10
            
        case .categoryName:
            return true
        }
        
    }
    
    func expenseIncomeSegmentPressed(index: Int){
        
        if index == 0 {
            category.typeEnum = .expense
        }
        else{
            category.typeEnum = .income
            view?.hideBalanceAmountErrorLabel() 
        }
        
    }
    
    func savePressed(){
        
        view?.animateSaveButton()
        
        do{
            try NewCategoryValidator.shared.checkRequiredValue(categoryValue: String(category.cost) , categoryName: &category.categoryName, type: category.typeEnum)
            
            RealmManger.shared.addCategory(category: category) { (result) in
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    self.view?.backToMain()
                }
            }
            
        }
        catch{
            view?.showErrorAlert(errorMessage: (error as! ValidationError).message)
        }
        
    }
    
    private func checkBalanceAmount(value: String?){
        
        guard let value = value, category.typeEnum == .expense else{
            return
        }
        
        do {
            
            try NewCategoryValidator.shared.isValidExpense(expenseValue: value, balanceValue: accountBalance!.currentBalance)
            view?.hideBalanceAmountErrorLabel()
            
        }
        catch {
            view?.showBalanceAmountErrorLabel((error as! ValidationError).message)
        }
        
    }
    
    private func updateMoneyAmount(value: String?) {
        
        guard let value = value else{
            return
        }
        category.cost = value.stringToFloat
    }
    
    private func updateCategoryName(name: String?) {
        
        guard let name = name else{
            return
        }
        category.categoryName = name.lowercased()
    }
    
    func addNotePressed(){
        view?.moveToAddNoteVC()
    }
    
    func backToMainPressed(){
        view?.backToMain()
    }
    
    
    func updateCategoryIcon(iconString: String?) {
        category.iconName = iconString
    }
    
    
    func finishNote(note: String?) {
        category.note = note
    }
    
}
