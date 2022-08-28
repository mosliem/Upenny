//
//  TransactionDetailsVCPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import Foundation

class TransactionDetailsVCPresenter: TransactionDetailsViewPresenter {
   
    weak var view: TransactionDetailsView?
    private var transactionDetails: CategoryEntryModel?
    
    required init(view: TransactionDetailsView, transaction: CategoryEntryModel?) {
        self.view = view
        self.transactionDetails = transaction
    }
    
    func viewDidLoad() {
        setupViewData()
    }
    
    
    func didPressBack() {
        view?.moveBackToMain()
    }
    
    func didPressDelete() {
        view?.showDeleteAlert(title: "Warning", message: "Are you sure you want to delete this transaction!")
    }
    
    func yesDeleteAlertPressed() {
        
        RealmManger.shared.deleteTransactionWithDate(date: transactionDetails!.date, transactionType: transactionDetails!.typeEnum) { (result) in
            
            switch result {
            
            case .success(_):
                self.view?.moveBackToMain()
            case .failure(let error):
                let errorMessage = (error as! RealmError).message
                self.view?.displayDeleteError(title: "Error", message: errorMessage, actionName: "OK")
            }
        }
    
    }
    
    private func setupViewData(){
        
        let categoryName = transactionDetails?.categoryName ?? ""
        let amount = "$" + (transactionDetails?.cost.ZeroDots)!
        let transactionType = transactionDetails?.type ?? ""
        let transactionDate = transactionDetails?.date.longDateString ?? ""
        let transactionNote = transactionDetails?.note ?? "No notes"
        
        view?.displayCategoryName(name: categoryName)
        view?.displayAmount(value: amount)
        view?.displayTransactionType(type: transactionType)
        view?.displayTransactionDate(dateString: transactionDate)
        view?.displayTransactionNote(note: transactionNote)
    }
}
