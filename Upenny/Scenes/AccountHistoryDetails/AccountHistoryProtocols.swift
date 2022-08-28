//
//  AccountHistoryProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/27/22.
//

import Foundation


enum AccountHistoryFilterType: Int, CaseIterable{
    
    case all = 0
    case income = 1
    case expense = 2
    
    static func IntToFilterType(index: Int) -> AccountHistoryFilterType{
        return self.allCases.first{$0.rawValue == index}!
    }
    
    
}

protocol AccountHistoryView: class {
     
    var presenter: AccountHistoryViewPresenter? {get set}
    
    func moveToMain()
    func viewNoAccountHistoryLabel()
    func hideNoAccountHistoryLabel()
    func reloadTableView()
    
}


protocol AccountHistoryViewPresenter: class {
    
    var view: AccountHistoryView? {get set}
    init(view: AccountHistoryView)
    
    func getAccountHistoryCount() -> Int
    func filterSegementPressed(type: AccountHistoryFilterType)
    func backPressed()
    func viewDidLoad()
    func configureCell(cell: AccountHistoryViewCell, indexPath: Int)

}
