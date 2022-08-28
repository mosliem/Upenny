//
//  CategoryExpensesDetailsDelegates.swift
//  Upenny
//
//  Created by mohamedSliem on 8/23/22.
//

import UIKit

extension CategoryExpensesDetailsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfEntries() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as! TransactionTableViewCell
        presenter?.configureCell(cell: cell, indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.viewStretchAnimatation()
        presenter?.didTapCell(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = CategoryEntriesTableViewHeader(frame: CGRect(x: 0, y: 0, width: view.width, height: 150))
        presenter?.configureCategoryEntriesTableHeader(HeaderView: headerView)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
}

extension CategoryExpensesDetailsVC: CategoryExpensesDetailsView {
    
    func moveToTransactionDetailsVC(transaction: CategoryEntryModel?) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TransactionDetailsVC") as! TransactionDetailsVC
        vc.transctionDetails = transaction
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func moveToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
