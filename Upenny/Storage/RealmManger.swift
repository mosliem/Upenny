//
//  RealmManger.swift
//  Upenny
//
//  Created by mohamedSliem on 8/16/22.
//

import RealmSwift

enum RealmError: String, Error{
    case AddNewCategoryError
    case GetTransactionBetweenDates
    case DeleteError
    
    var message: String {
        
        switch self {
        case .AddNewCategoryError:
            return "Can't add this transaction, please try again"
        case .GetTransactionBetweenDates:
            return "Error with getting transaction for this date interval"
        case .DeleteError:
            return "Can't delete this transaction!"
        }
    }
}

enum IndexType: Int, CaseIterable {
    case Week = 0
    case Month = 1
    
    static func indexToEnum(_ index: Int) -> IndexType {
        return self.allCases.first{$0.rawValue == index}!
    }
}

class RealmManger {
    
    private let realmLocal = try! Realm()
    
    public static let shared = RealmManger()
    
    private init(){}
    
    //MARK:- adding new objects to realm database Functions
    
    func addCategory(category: CategoryEntryModel, completion: @escaping(Result<Bool , Error>) -> Void){
        
        do {
            try realmLocal.write{
                realmLocal.add(category)
            }
            completion(.success(true))
            
        }catch{
            completion(.failure(error))
        }
        
        addAccountHistoryEntry(type: category.typeEnum, value: category.cost, date: category.date)
        addTransactionToAccountBalance(type: category.typeEnum, value: category.cost)
    }
    
    func addAccountHistoryEntry(type: TransactionType, value: Float, date: Date){
        
        let newHistoryEntry = AccountHistoryModel()
        newHistoryEntry.typeEnum = type
        newHistoryEntry.value = value
        newHistoryEntry.date = date
        
        do {
            try realmLocal.write{
                realmLocal.add(newHistoryEntry)
            }
        }
        catch{
            print(error)
        }
        
    }
    
    private func addTransactionToAccountBalance(type: TransactionType, value: Float){
        
        let accountBalance = realmLocal.objects(AccountBalanceModel.self).first
        do{
            try realmLocal.write{
                
                switch type {
                
                case .expense:
                    accountBalance?.currentBalance -=  value
                    accountBalance?.currentTotalExpense += value
                    
                case .income:
                    accountBalance?.currentBalance += value
                    accountBalance?.currentTotalIncome += value
                    
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    //MARK:- getting objects from realm database Functions
    
    func getAccountHistory(completion: @escaping([AccountHistoryModel]) -> ()){
        let accountHistory = realmLocal.objects(AccountHistoryModel.self).sorted(byKeyPath: "date", ascending: false)
        let result = accountHistory.toArray(type: AccountHistoryModel.self)
        completion(result)
    }
    
    func getAccountBalance(completion: @escaping(AccountBalanceModel) ->()) {
        
        guard let accountBalance = realmLocal.objects(AccountBalanceModel.self).first else{
            return
        }
        completion(accountBalance)
    }
    
    
    func getTransationsBetweenDates(
        from startDate: Date,
        to endDate: Date,
        completion: @escaping([[CategoryEntryModel]]) -> ()
    ){
        
        let transactions = realmLocal.objects(CategoryEntryModel.self)
        
        let result = transactions.filter(
            "date >= %@ AND date <= %@",
            startDate ,
            endDate
        ).sorted(byKeyPath: "date",
                 ascending: false
        ).toArray(type: CategoryEntryModel.self)
        
        // Indexing the result with dates
        
        let indexedData = indexToWeekData(result)
        
        completion(indexedData)
    }
    
    
    func getIndexedExpenseTransactionsBetweenDates(
        from startDate: Date,
        to endDate: Date,
        indexType: IndexType,
        completion: @escaping([[CategoryEntryModel]]) -> ()
    ){
        
        let result = realmLocal.objects(CategoryEntryModel.self)
            .filter(
                "date >= %@ AND date <= %@ AND type = %@ ",
                startDate,
                endDate,
                "expense"
            ).sorted(byKeyPath: "date", ascending: false)
            .toArray(type: CategoryEntryModel.self)
        
        var indexedData: [[CategoryEntryModel]]
        switch indexType{
        
        case .Week:
            indexedData = indexToWeekData(result)
        case .Month:
            indexedData = indexToMonthData(result)
            
        }
        
        completion(indexedData)
    }
    
    
    ///Returns a categories dictionary and an array of dictionary key indexes.
    
    func getExpenseTransactionsBetweenDates(
        from startDate: Date,
        to endDate: Date,
        completion: @escaping([String:[CategoryEntryModel]]) -> ()
    ){
        
        let result = realmLocal.objects(CategoryEntryModel.self)
            .filter(
                "date >= %@ AND date <= %@ AND type = %@",
                startDate,
                endDate,
                "expense"
            ).sorted(byKeyPath: "cost", ascending: false)
            .toArray(type: CategoryEntryModel.self)
        
        
        var expensesDictionary = [String:[CategoryEntryModel]]()
        
        // grouping categories by name  in dictionary
        for expense in result {
            
            let expenseName = expense.categoryName
            var expenseArray = expensesDictionary[expenseName] ?? [CategoryEntryModel]()
            
            expenseArray.append(expense)
            expensesDictionary.updateValue(expenseArray, forKey: expenseName)
        }
 
        completion(expensesDictionary)
    }
    
    //MARK:- Deleting object function from realm
    
    func deleteTransactionWithDate(date: Date, transactionType: TransactionType, completion: @escaping (Result<Bool , Error>) -> ()){
        
        let transaction = realmLocal.objects(CategoryEntryModel.self).filter("date = %@", date)
        let transactionValue = (transaction.first?.cost)!
        
        do{
            try realmLocal.write{
                realmLocal.delete(transaction)
            }
            
            deleteTransactionFromAccountBalance(value: transactionValue, transactionType: transactionType)
            completion(.success(true))
        }
        catch{
            completion(.failure(RealmError.DeleteError))
        }
    }
    
    private func deleteTransactionFromAccountBalance(value: Float, transactionType: TransactionType){
        
        let accountBalance = realmLocal.objects(AccountBalanceModel.self).first
        
        do{
            try realmLocal.write{
                
                switch transactionType {
                
                case .expense:
                    accountBalance?.currentBalance +=  value
                    accountBalance?.currentTotalExpense -= value
                    
                case .income:
                    accountBalance?.currentBalance -= value
                    accountBalance?.currentTotalIncome -= value
                }
            }
        }
        catch {
            print(error)
        }
        
    }
    
    private func deleteTransactionHistory(date: Date){
        
        let transactionHistory = realmLocal.objects(AccountHistoryModel.self).filter("date = %@", date)
        
        do{
            
            try realmLocal.write{
                realmLocal.delete(transactionHistory)
            }
        }
        catch{
            print(RealmError.DeleteError)
        }
        
    }
    
    
    //MARK:- Indexing data
    
    func indexToWeekData(_ transactions: [CategoryEntryModel]) -> [[CategoryEntryModel]]{
        
        var indexedResult = Array<Array<CategoryEntryModel>>(repeating: [], count: 7)
        var i = 0
        var lastDate = transactions.first?.date.dateString
        for transaction in transactions {
            
            if lastDate != transaction.date.dateString {
                lastDate = transaction.date.dateString
                i += 1
            }
            indexedResult[i].append(transaction)
        }
        return indexedResult
    }
    
    func indexToMonthData(_ transactions: [CategoryEntryModel]) -> [[CategoryEntryModel]]{
        
        var indexedResult = Array<Array<CategoryEntryModel>>(repeating: [], count: 30)
        var i = 0
        var lastDate = transactions.first?.date.dateString
        
        for transaction in transactions {
            
            if lastDate != transaction.date.dateString {
                lastDate = transaction.date.dateString
                i += 1
            }
            indexedResult[i].append(transaction)
        }
        return indexedResult
    }
}

