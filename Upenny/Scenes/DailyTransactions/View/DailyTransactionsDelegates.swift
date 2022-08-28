//
//  DailyExpenseTableViewDelegates.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import UIKit

extension DailyTransactionsVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getNumberOfSections() ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getTransactionsPerSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TransactionTableViewCell.identifier,
            for: indexPath) as! TransactionTableViewCell
        
        
        presenter?.configureCell(cell: cell, section: indexPath.section, indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.viewStretchAnimatation()
        presenter?.didTapCell(section: indexPath.section, indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let dateString = presenter?.dateStringForSectionHeader(section: section)
        let total = presenter?.totalTransactionValueForSection(section: section)
        
        let view = TransactionCellSectionView(frame: CGRect(x: 10, y: 0, width: tableView.width - 20, height: 50))
        view.configure(title: dateString!, total: total!)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat((presenter?.heightForSection(section: section))!)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let deleteAction = UIAction(title: "Delete",image: UIImage(systemName: "trash.fill"),  attributes: .destructive, handler: { (action) in
                self.presenter?.deleteCellAtIndex(section: indexPath.section, indexPath: indexPath.row)
            })
            
            return UIMenu(title: "select an option", options: .destructive, children: [deleteAction])
        }
        
    }
    
}

extension DailyTransactionsVC: DailyTransactionView {
    
    func balanceViewAnimation() {
        balanceView.viewStretchAnimatation()
    }
    
    func setBalanceValue(value: String) {
        
        self.balanceValueLabel.text = value
        
    }
    
    func setIncomeValue(value: String) {
        
        self.incomeValueLabel.text = value
        
    }
    
    func setExpenseValue(value: String) {
        
        self.expenseValueLabel.text = value
        
    }
    
    func reloadData() {
        dailyExpensesTableView.reloadData()
    }
    
    func showActionAlert(title: String, alertMessage: String){
        
        self.showYesNoAlert(alertTitle: title, message: alertMessage, yesHandler: { (yesAction) in
            self.presenter?.yesDeleteAlertPressed()
        }, noHandler: nil)
        
    }
    
    func showNoTransactionsLabel(){
        dailyExpensesTableView.isHidden = true
        noTransactionsLabel.isHidden = false
    }
    
    func hideNoTransactionsLabel(){
        dailyExpensesTableView.isHidden = false
        noTransactionsLabel.isHidden = true
    }
    
    
    func moveToTransactionDetailsVC(selectedTransaction: CategoryEntryModel){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TransactionDetailsVC") as! TransactionDetailsVC
        vc.transctionDetails = selectedTransaction
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func displayErrorAlert(title: String, message: String, actionName: String) {
        self.showAlertWithOk(alertTitle: title, message: message, actionTitle: actionName)
    }
    
    func moveToAccountHistoryVC() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountHistoryDetailsVC") as! AccountHistoryDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

