//
//  TransactionDetailsVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import UIKit

class TransactionDetailsVC: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var amountValueLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var presenter: TransactionDetailsVCPresenter?
    var transctionDetails: CategoryEntryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter = TransactionDetailsVCPresenter(view: self, transaction: transctionDetails)
        configureNavBarView()
        presenter?.viewDidLoad()
    }
    
    func configureNavBarView(){
        
        navBarView.layer.shadowColor = UIColor.lightGray.cgColor
        navBarView.layer.shadowRadius = 5
        navBarView.layer.shadowOpacity = 0.4
        navBarView.layer.shadowOffset = CGSize(width: 0, height: 2.5)
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        presenter?.didPressBack()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        presenter?.didPressDelete()
    }
}
