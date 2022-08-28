//
//  DailyTransactionCellProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/18/22.
//

import Foundation

protocol DailyTransactionViewCell: class {
   
    func displayCategoryName(categoryName: String?)
    func displayCategoryIcon(categoryIconName: String?)
    func displayTransactionTime(timeString: String?)
    func displayIncomeValue(value: String?)
    func displayExpenseValue(value: String?)
}
