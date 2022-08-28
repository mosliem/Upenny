//
//  CategoryExpensesDetailsProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import Foundation

protocol CategoryExpensesDetailsView: class {
    
    var presenter: CategoryExpensesDetailsViewPresenter? {get set}
    func moveToMain()
    func moveToTransactionDetailsVC(transaction: CategoryEntryModel?)
    
}

protocol CategoryExpensesDetailsViewPresenter: class {
    
    var view: CategoryExpensesDetailsView? {get set}
    init(view: CategoryExpensesDetailsView?, entries: [CategoryEntryModel]?)
    
    func numberOfEntries() -> Int
    func configureCell(cell: TransactionTableViewCell, indexPath: Int)
    func  didTapCell(indexPath: Int)
    func configureCategoryEntriesTableHeader(HeaderView: CategoryEntriesTableHeaderView)
    func backPressed()
}

protocol CategoryEntriesTableHeaderView: class {
    func displayCategoryName(name: String)
    func displayIconImage(icon: String?)
    func displayExpensesValue(value: String)
    func displayCategoryEntriesNumber(value: String)
}
