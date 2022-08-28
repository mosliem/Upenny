//
//  NewCategoryValidation.swift
//  Upenny
//
//  Created by mohamedSliem on 8/17/22.
//

import Foundation


struct ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

class NewCategoryValidator {
    
    static let shared = NewCategoryValidator()
    
    private var validProcess: Bool
    
    private init(){
        validProcess = false
    }
    
    func isValidExpense(expenseValue: String, balanceValue: Float) throws {
        
        updateProcessValidation(state: false)
        
        guard !expenseValue.isEmpty else {
            updateProcessValidation(state: false)
            return
        }
        guard expenseValue.stringToFloat < balanceValue else{
            updateProcessValidation(state: false)
            throw ValidationError("You can't afford this!")
        }
        
        guard expenseValue.stringToFloat > 0 else{
            updateProcessValidation(state: false)
            throw ValidationError("Enter a valid value")
        }
        
        updateProcessValidation(state: true)
    }
    
    
    func checkRequiredValue(categoryValue: String, categoryName: inout String, type: TransactionType) throws {

        guard type == .expense else{
            updateProcessValidation(state: true)
            return
        }
        stringLeadingTrailingSpace(string: &categoryName)
        
        guard validProcess else{
         throw ValidationError("Please enter valid information")
        }
        
        guard  !categoryValue.isEmpty else {
            throw ValidationError( "Sorry! you should enter a valid money number")
        }
        
        guard !categoryName.isEmpty else {
             throw ValidationError("Sorry! you should enter a category name")
        }
        
    }
    
    func stringLeadingTrailingSpace(string: inout String){
        string.trimmingLeadingTrailingSpaces()
    }
    
    private func updateProcessValidation(state: Bool){
         validProcess = state
    }
}
