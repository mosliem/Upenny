//
//  TotalCategoryExpensesCellProtocol.swift
//  Upenny
//
//  Created by mohamedSliem on 8/22/22.
//

import Foundation

protocol TotalCategoryExpensesCellView {
    
    func displayCategoryIcon(categoryIconString: String?)
    func displayCategoryName(categoryName: String)
    func displayCategoryEntriesNumber(number: String)
    func displayExpenseTotalValue(value: String)
    func displayPrecentageValue(value: String)
    func displayWarningPrecentageValue(value: String)
}
