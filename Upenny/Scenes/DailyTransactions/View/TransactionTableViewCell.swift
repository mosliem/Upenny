//
//  DailyExpensesTableViewCell.swift
//  Upenny
//
//  Created by mohamedSliem on 8/11/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dailyTransactionCellView: UIView!
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var transactionTimeLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    static let identifier = "DailyTransactionTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        dailyTransactionCellView.layer.cornerRadius = 15
        dailyTransactionCellView.layer.masksToBounds = false
        dailyTransactionCellView.layer.shadowColor = UIColor.lightGray.cgColor
        dailyTransactionCellView.layer.shadowRadius = 10
        dailyTransactionCellView.layer.shadowOpacity = 0.3
        dailyTransactionCellView.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryIconImageView.image = nil
        categoryNameLabel.text = nil
        transactionTimeLabel.text = nil
        transactionValueLabel.text = nil
        
    }
}

extension TransactionTableViewCell: DailyTransactionViewCell{
    
    func displayCategoryName(categoryName: String?) {
        categoryNameLabel.text = categoryName
    }
    
    func displayCategoryIcon(categoryIconName: String?) {
        
        guard let emojiString = categoryIconName else {
            return
        }
        
        DispatchQueue.main.async {
            self.categoryIconImageView.image = emojiString.emojiToIconImage()
        }
    }
    
    func displayTransactionTime(timeString: String?) {
        transactionTimeLabel.text = timeString
    }
    
    func displayIncomeValue(value: String?) {
        transactionValueLabel.text = value
        transactionValueLabel.textColor = .systemGreen
    }
    
    func displayExpenseValue(value: String?) {
        transactionValueLabel.text = value
        transactionValueLabel.textColor = .systemRed
    }
    
    
}
