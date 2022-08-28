//
//  CategoryExpensesDetailsVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import UIKit

class CategoryExpensesDetailsVC: UIViewController {
    
    @IBOutlet weak var categoryEntriesTableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    var presenter: CategoryExpensesDetailsViewPresenter?
    var categoryEntries: [CategoryEntryModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CategoryExpensesDetailsVCPresenter(view: self, entries: categoryEntries)
       configureView()
    }
    
    private func configureView(){
        configurecategoryEntriesTableView()
        configureBackButton()
    }
    
    private func configurecategoryEntriesTableView(){
        
        categoryEntriesTableView.delegate = self
        categoryEntriesTableView.dataSource = self
        
        categoryEntriesTableView.register(UINib(nibName: TransactionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TransactionTableViewCell.identifier)
    }
    
    private func configureBackButton(){
        
        backButton.roundButtonWithShadows(
            cornerRadius: 10,
            shadowRadius: 5,
            shadowOpicity: 0.4,
            shadowOffset: CGSize(width: 0, height: 2.5),
            shadowColor: .lightGray
        )
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        presenter?.backPressed()
    }
}
