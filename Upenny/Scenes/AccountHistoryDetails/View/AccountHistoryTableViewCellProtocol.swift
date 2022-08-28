//
//  AccountHistoryTableCellView.swift
//  Upenny
//
//  Created by mohamedSliem on 8/24/22.
//

import Foundation

protocol AccountHistoryViewCell {
 
    func displayIncomeLabel()
    func displayExpenseLabel()
    func displayIncomeImageView()
    func displayExpenseImageView()
    func displayTransactionDate(dateString: String)
    func displayTransactionValue(value: String)
}
