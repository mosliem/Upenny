//
//  CategoryExpensesDetailsVCPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import Foundation

class CategoryExpensesDetailsVCPresenter: CategoryExpensesDetailsViewPresenter {
    
    weak var view: CategoryExpensesDetailsView?
    private var categoryEntries: [CategoryEntryModel]?
    
    required init(view: CategoryExpensesDetailsView?, entries: [CategoryEntryModel]?) {
        self.view = view
        self.categoryEntries = entries
    }
    
    func numberOfEntries() -> Int {
        return categoryEntries?.count ?? 0
    }
    
    func configureCell(cell: TransactionTableViewCell, indexPath: Int) {
        
        let entry = categoryEntries?[indexPath]
        let iconString = entry?.iconName
        let amount = "$" + (entry?.cost.ZeroDots ?? "")
        let categoryName = entry?.categoryName
        let dateString = entry?.date.fullDateString
        
        cell.displayCategoryIcon(categoryIconName: iconString)
        cell.displayCategoryName(categoryName: categoryName)
        
        switch entry!.typeEnum {
        case .expense:
            cell.displayExpenseValue(value: amount)
        case .income:
            cell.displayIncomeValue(value: amount)
        }
        
        cell.displayTransactionTime(timeString: dateString)
    }
    
    func didTapCell(indexPath: Int) {
        let selectedTransaction = categoryEntries?[indexPath]
        view?.moveToTransactionDetailsVC(transaction:selectedTransaction)
    }
    
    func configureCategoryEntriesTableHeader(HeaderView: CategoryEntriesTableHeaderView){
       
        let totalCategoryExpenses = "$" + (categoryEntries?.map{$0.cost}.reduce(0, +).ZeroDots ?? "")
        let iconString = categoryEntries?.first?.iconName
        let enriesCount = String(categoryEntries?.count ?? 0) + " entries"
        let categoryName = categoryEntries?.first?.categoryName ?? ""
        
        HeaderView.displayCategoryEntriesNumber(value: enriesCount)
        HeaderView.displayIconImage(icon: iconString)
        HeaderView.displayExpensesValue(value: totalCategoryExpenses)
        HeaderView.displayCategoryName(name: categoryName)
    }
    
    
    func backPressed() {
        view?.moveToMain()
    }
}
