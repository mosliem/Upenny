//
//  TabBarPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/11/22.
//

import Foundation


class TabBarPresenter: TabBarViewPresenterProtocol {
    
    weak var tabBarView: TabBarViewProtocol?
    
    init(tabBarView: TabBarViewProtocol ) {
        self.tabBarView = tabBarView
    }
    
    //MARK:- Protocols Methods
    
    func didTapAddTransaction() {
        
        tabBarView?.moveToAddTransactionVC()
    
    }
}
