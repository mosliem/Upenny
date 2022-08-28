//
//  TransactionDetailsProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import Foundation

protocol TransactionDetailsView: class {
    
    var presenter: TransactionDetailsVCPresenter? {get set}
    func moveBackToMain()
    func showDeleteAlert(title:String, message: String)
    func displayCategoryName(name: String)
    func displayAmount(value: String)
    func displayTransactionType(type: String)
    func displayTransactionDate(dateString: String)
    func displayTransactionNote(note: String?)
    func displayDeleteError(title: String, message: String, actionName: String)
}

protocol TransactionDetailsViewPresenter: class {
    
    var view: TransactionDetailsView? {get set}
    init(view: TransactionDetailsView, transaction: CategoryEntryModel?)
    func viewDidLoad()
    func didPressBack()
    func didPressDelete()
    func yesDeleteAlertPressed()
    
}
