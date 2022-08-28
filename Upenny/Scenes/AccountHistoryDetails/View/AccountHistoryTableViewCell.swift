//
//  TableViewCell.swift
//  Upenny
//
//  Created by mohamedSliem on 8/24/22.
//

import UIKit

class AccountHistoryTableViewCell: UITableViewCell {

    static let identifer = "AccountHistoryTableViewCell"
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var upAndDownImageView: UIImageView!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        configureCellView()
        configureUpAndDownImageView()
    }
     
    private func configureCellView(){
        cellView.layer.cornerRadius = 12
        cellView.layer.shadowRadius = 5
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        
    }
    
    private func configureUpAndDownImageView(){
        upAndDownImageView.clipsToBounds = true
        upAndDownImageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        upAndDownImageView.image = nil
        transactionDateLabel.text = nil
        transactionTypeLabel.text = nil
        transactionValueLabel.text = nil
    }
    
}

extension AccountHistoryTableViewCell: AccountHistoryViewCell{
   
    func displayIncomeLabel() {
        transactionTypeLabel.text = "Income"
        transactionTypeLabel.textColor = .systemGreen
    }
    
    func displayExpenseLabel() {
        transactionTypeLabel.text = "Expense"
        transactionTypeLabel.textColor = .systemRed
    }
    
    
    func displayIncomeImageView() {
        upAndDownImageView.image = UIImage(systemName: "arrow.up")
        upAndDownImageView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        upAndDownImageView.tintColor = .systemGreen
    }
    
    func displayExpenseImageView() {
        upAndDownImageView.image = UIImage(systemName: "arrow.down")
        upAndDownImageView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        upAndDownImageView.tintColor = .systemRed
    }
    
    func displayTransactionDate(dateString: String) {
        transactionDateLabel.text = dateString
    }
    
    func displayTransactionValue(value: String) {
        transactionValueLabel.text = value
    }
    
    
}
