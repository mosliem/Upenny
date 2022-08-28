//
//  DailyExpensesDetailsVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/10/22.
//

import UIKit

class DailyTransactionsVC: UIViewController {

    

    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var incomeValueLabel: UILabel!
    @IBOutlet weak var expenseValueLabel: UILabel!
    @IBOutlet weak var incomeImageView: UIImageView!
    @IBOutlet weak var expenseImageView: UIImageView!
    @IBOutlet weak var dailyExpensesTableView: UITableView!
    @IBOutlet weak var noTransactionsLabel: UILabel!
    @IBOutlet weak var accountHistoryButton: UIButton!
    
    var presenter: DailyTransactionsVCPresenter?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
        self.presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        renderBalanceView()
        configureTableView()
        presenter = DailyTransactionsVCPresenter(view: self)
    }
    

    
    private func renderBalanceView(){
        
        //balance view
        
        balanceView.layer.cornerRadius = 18
        balanceView.layer.masksToBounds = false
        balanceView.layer.shadowColor = UIColor.systemPurple.cgColor
        balanceView.layer.shadowRadius = 10
        balanceView.layer.shadowOpacity = 0.4
        balanceView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        //income Image view
        
        incomeImageView.layer.cornerRadius = 12.5
        incomeImageView.clipsToBounds = true
        
        // expense image view
        
        expenseImageView.layer.cornerRadius = 12.5
        expenseImageView.clipsToBounds = true
            
    }


    private func configureTableView(){
        
        dailyExpensesTableView.delegate = self
        dailyExpensesTableView.dataSource = self
        
        dailyExpensesTableView.register(
            UINib(nibName: TransactionTableViewCell.identifier,
                  bundle: nil),
            forCellReuseIdentifier: TransactionTableViewCell.identifier
        )
    
    }

    @IBAction func didPressedAccountHistoryButton(_ sender: UIButton) {
        presenter?.balanceViewPressed()
    }
}
