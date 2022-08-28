//
//  TransactionDetailsDelegates.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import Foundation

extension TransactionDetailsVC: TransactionDetailsView {

    func displayCategoryName(name: String) {
        categoryNameLabel.text = name
    }
    
    func displayAmount(value: String) {
        amountValueLabel.text = value
    }
    
    func displayTransactionType(type: String) {
        transactionTypeLabel.text = type
    }
    
    func displayTransactionDate(dateString: String) {
        dateLabel.text = dateString
    }
    
    func displayTransactionNote(note: String?) {
        noteTextView.text = note
    }
    
    
    func showDeleteAlert(title: String, message: String) {
        
        self.showYesNoAlert(alertTitle: title, message: message, yesHandler: { (action) in
            self.presenter?.yesDeleteAlertPressed()
        }, noHandler: nil)
    }
    
    func moveBackToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func displayDeleteError(title: String, message: String, actionName: String) {
        self.showAlertWithOk(alertTitle: title, message: message, actionTitle: actionName)
    }
    
}
