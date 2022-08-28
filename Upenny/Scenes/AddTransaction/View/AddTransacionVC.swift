//
//  AddExpensesVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/11/22.
//

import UIKit
import MemojiView

class AddTransacionVC: UIViewController{
    
    @IBOutlet weak var moneyAmountTextField: CustomTextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var categoryNameTextField: CustomTextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryIconView: MemojiView!
    @IBOutlet weak var BalanceErrorLabel: UILabel!
    @IBOutlet weak var transactionTimeLabel: UILabel!
    
    var presenter: AddTransactionViewPresenter?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        moneyAmountTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        presenter = AddTransactionPresenter(view: self)
        presenter?.viewDidLoad()

    }
    
    private func configureViews(){
        
        categoryIconView.delegate = self
        configureBackButton()
        configureMoneyAmountTextField()
        configureCategoryNameTextField()
        configureSaveButton()
        configureCategoryIconView()
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
    
    private func configureMoneyAmountTextField(){
        
        moneyAmountTextField.delegate = self
        moneyAmountTextField.renderBottomLine(width: 45)
        moneyAmountTextField.renderTextFeildLeftIcon()
    }
    
    private func configureCategoryNameTextField(){
        categoryNameTextField.delegate = self
        categoryNameTextField.renderBottomLine(width: 170)
        
    }

    
    private func configureSaveButton(){
        
        saveButton.roundButtonWithShadows(
            cornerRadius: 10,
            shadowRadius: 4,
            shadowOpicity: 0.3,
            shadowOffset: CGSize(width: 0, height: 2),
            shadowColor: .systemBlue
        )


    }
    
    private func configureCategoryIconView(){
        
        categoryIconView.image = nil
        categoryIconView.tintColor = UIColor.randomColor
        categoryIconView.showEditButton = false

    }
    
}

extension AddTransacionVC {
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        presenter?.backToMainPressed()
    }
    
    
    @IBAction func didPressAddNoteButton(_ sender: UIButton) {
     
        presenter?.addNotePressed()
        
    }
    
    
    @IBAction func didPressExpenseIncomeSegment(_ sender: UISegmentedControl) {
        
        presenter?.expenseIncomeSegmentPressed(index: sender.selectedSegmentIndex)
    
    }
    
    
    @IBAction func didPressSaveButton(_ sender: Any) {
        
        presenter?.savePressed()
        
    }
}
