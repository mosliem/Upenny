//
//  CategoryEntry.swift
//  Upenny
//
//  Created by mohamedSliem on 8/16/22.
//

import RealmSwift


class CategoryEntryModel: Object{
    
    @Persisted var categoryName: String
    @Persisted var note: String?
    @Persisted var date: Date
    @Persisted var cost: Float
    @Persisted var iconName: String?
    
    @Persisted var type = TransactionType.expense.rawValue
    
    var typeEnum: TransactionType {
        get{
            return TransactionType(rawValue: type)!
        }
        set{
            type = newValue.rawValue
        }
    }
}
