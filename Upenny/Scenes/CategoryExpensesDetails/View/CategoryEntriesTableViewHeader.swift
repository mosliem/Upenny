//
//  CategoryEntriesTableViewHeader.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import UIKit

class CategoryEntriesTableViewHeader: UIView {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private let entriesNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private let expenseValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryName)
        addSubview(expenseValue)
        addSubview(entriesNumber)
        addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        iconImageView.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        categoryName.frame = CGRect(x: iconImageView.right + 25, y: 30, width: self.width - iconImageView.width - 25, height: 30)
        entriesNumber.frame = CGRect(x: iconImageView.right + 25, y: 70, width: (self.width - iconImageView.width) / 2 - 25, height: 30)
        expenseValue.frame = CGRect(x: entriesNumber.right , y: 70, width: (self.width - iconImageView.width) / 2 - 25, height: 30)
        configureViewShadow()

    }

    private func configureViewShadow(){
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2.5)
    }
}

extension CategoryEntriesTableViewHeader: CategoryEntriesTableHeaderView{
    
    func displayCategoryName(name: String) {
        categoryName.text = name
    }
    
   
    func displayIconImage(icon: String?) {
        DispatchQueue.main.async {
            self.iconImageView.image = icon?.emojiToIconImage()
        }
    }
    
    func displayExpensesValue(value: String) {
        expenseValue.text =  value
    }
    
    func displayCategoryEntriesNumber(value: String) {
        entriesNumber.text = value
    }
    
    
}
