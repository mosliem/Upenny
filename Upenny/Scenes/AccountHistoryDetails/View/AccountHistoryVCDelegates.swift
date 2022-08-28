//
//  AccountHistoryVCDelegates.swift
//  Upenny
//
//  Created by mohamedSliem on 8/24/22.
//

import UIKit


extension AccountHistoryDetailsVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getAccountHistoryCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountHistoryTableViewCell.identifer, for: indexPath) as! AccountHistoryTableViewCell
        presenter?.configureCell(cell: cell, indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


extension AccountHistoryDetailsVC: AccountHistoryView{
    
    func hideNoAccountHistoryLabel() {
        noHistoryLabel.isHidden = true
    }
    
 
    func moveToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewNoAccountHistoryLabel() {
        noHistoryLabel.isHidden = false
    }
    
    func reloadTableView() {
        transactionsTableView.isHidden = false
        transactionsTableView.reloadData()
    }
    
    
}
