//
//  TransactionCellSectionView.swift
//  Upenny
//
//  Created by mohamedSliem on 8/19/22.
//

import UIKit


class TransactionCellSectionView: UIView{
    
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let sectionTotal: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(sectionTitle)
        self.addSubview(sectionTotal)
        renderBottomLine()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionTitle.frame = CGRect(x: 20, y: 10, width: 100, height: 30)
        sectionTotal.frame = CGRect(x: self.right - 85, y: 10, width: 100, height: 30)
        
        
    }
    
    
    func renderBottomLine(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 10, y: self.height - 1, width: self.width - 2, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        bottomLine.opacity = 0.4
        self.layer.addSublayer(bottomLine)
    }
    
    func configure(title: String, total: String){
        sectionTotal.text = total
        sectionTitle.text = title
    }
}
