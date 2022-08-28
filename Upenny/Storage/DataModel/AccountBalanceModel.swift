//
//  AccountBalanceDataModel.swift
//  Upenny
//
//  Created by mohamedSliem on 8/16/22.
//

import RealmSwift

class AccountBalanceModel: Object{
    
    @Persisted var currentTotalIncome: Float = 0
    @Persisted var currentTotalExpense: Float = 0
    @Persisted var currentBalance: Float = 0

    
}
