//
//  TabBarProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/11/22.
//

import Foundation


protocol TabBarViewProtocol: class {
    
    var presenter: TabBarPresenter? {get set}
    func moveToAddTransactionVC()
    
}

protocol TabBarViewPresenterProtocol: class {
    
    var tabBarView: TabBarViewProtocol? {get set}
    func didTapAddTransaction()

}
