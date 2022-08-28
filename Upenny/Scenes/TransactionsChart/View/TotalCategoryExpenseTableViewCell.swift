//
//  TotalCategoryExpenseTableViewCell.swift
//  Upenny
//
//  Created by mohamedSliem on 8/14/22.
//

import UIKit

class TotalCategoryExpenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var totalCategoryExpenseCellView: UIView!
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryEntriesNumberLabel: UILabel!
    @IBOutlet weak var totalExpenseLabel: UILabel!
    @IBOutlet weak var precentageValueLabel: UILabel!
    
    static let identifier = "TotalCategoryExpenseTableViewCell"
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        totalCategoryExpenseCellView.layer.cornerRadius = 15
        totalCategoryExpenseCellView.layer.masksToBounds = false
        totalCategoryExpenseCellView.layer.shadowColor = UIColor.lightGray.cgColor
        totalCategoryExpenseCellView.layer.shadowRadius = 10
        totalCategoryExpenseCellView.layer.shadowOpacity = 0.3
        totalCategoryExpenseCellView.layer.shadowOffset = CGSize(width: 0, height: 5)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryIconImageView.image = nil
        categoryNameLabel.text = nil
        categoryEntriesNumberLabel.text = nil
        totalExpenseLabel.text = nil
        precentageValueLabel.text = nil
    }
   
}


extension TotalCategoryExpenseTableViewCell: TotalCategoryExpensesCellView {
    
  
    
    
    func displayCategoryName(categoryName: String) {
        categoryNameLabel.text = categoryName
    }
    
    func displayCategoryEntriesNumber(number: String) {
        categoryEntriesNumberLabel.text = number
    }
    
    func displayExpenseTotalValue(value: String) {
        totalExpenseLabel.text = value
    }
    
    func displayPrecentageValue(value: String) {
        precentageValueLabel.textColor = .systemGreen
        precentageValueLabel.text = value
    }
    
    func displayWarningPrecentageValue(value: String) {
        precentageValueLabel.textColor = .systemRed
        precentageValueLabel.text = value
    }
    
    func displayCategoryName(categoryName: String?) {
        categoryNameLabel.text = categoryName
    }
    
    func displayCategoryIcon(categoryIconString categoryIconName: String?) {
        
        guard let emojiString = categoryIconName else {
            return
        }
        
        DispatchQueue.main.async {
            self.categoryIconImageView.image = emojiString.emojiToIconImage()
        }
    }
    

    
}
