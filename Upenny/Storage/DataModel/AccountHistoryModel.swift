//
//  AccountDataModel.swift
//  Upenny
//
//  Created by mohamedSliem on 8/16/22.
//

import Foundation
import RealmSwift


enum TransactionType: String, CaseIterable {
    case expense
    case income
    
    static func stringToType(string: String) -> TransactionType{
        return self.allCases.first{ $0.rawValue == string }!
    }
}

class AccountHistoryModel: Object{


    @Persisted var transactionType = TransactionType.expense.rawValue
    @Persisted var value: Float
    @Persisted var date: Date
    /// manipulate the transactionType var
    var typeEnum: TransactionType {
        get{
            return TransactionType(rawValue: transactionType)!
        }
        set{
            transactionType = newValue.rawValue
        }
    }
}




