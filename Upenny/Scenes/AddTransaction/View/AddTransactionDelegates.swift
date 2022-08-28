//
//  TextFieldDelegates.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import UIKit
import MemojiView

extension AddTransacionVC: UITextFieldDelegate {
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let type = TransactionField.typeFromString(string: textField.accessibilityIdentifier!)
        presenter?.textDidChanaged(transactionField: type, text: textField.text)
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let type = TransactionField.typeFromString(string: textField.accessibilityIdentifier!)
        // Range for Number TextField
        return presenter?.textShouldChanage(textField.placeholder, text: textField.text, range: range, replacementString: string, fieldType: type) ?? true
    }
    
    
}

// delegate for category view
/// handling the emoji image padding

extension AddTransacionVC: MemojiViewDelegate{
    
    func didUpdateImage(image: UIImage, type: ImageType, emojiText: String?) {
        
        categoryIconView.imageInsets = UIEdgeInsets(top: 0 , left: 3, bottom: 0, right: 3)
        presenter?.updateCategoryIcon(iconString: emojiText)
    }
    
}

extension AddTransacionVC: AddNoteDelegate{
    
    func saveNote(text: String) {
        presenter?.finishNote(note: text)
    }
    
}


//MARK:- AddExpensesView Protocols methods

extension AddTransacionVC: AddTransactionView{
    
    func setTransactionTime(time: String) {
        transactionTimeLabel.text = time
    }
    
    
    func updateCategoryTextFieldFrame() {
        
        categoryNameTextField.sizeToFit()
        categoryNameTextField.layoutIfNeeded()
        categoryNameTextField.updateBottomLineWidth(width: categoryNameTextField.frame.width)
        
    }
    
    func updateMoneyAmountTextFieldFrame() {
        
        moneyAmountTextField.sizeToFit()
        moneyAmountTextField.layoutIfNeeded()
        moneyAmountTextField.updateBottomLineWidth(width: moneyAmountTextField.frame.width)
        
    }
    
    func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func animateSaveButton(){
        saveButton.viewStretchAnimatation()
    }
    
    func moveToAddNoteVC(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNoteVC") as! AddNoteVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.addNoteDelegate = self
        present(vc, animated: true, completion: nil)
        
    }
    
    
    func getCategoryName() -> String? {
        return categoryNameTextField.text
    }
    
    func getCategoryCost() -> String? {
        return moneyAmountTextField.text
    }
    
    
    func showBalanceAmountErrorLabel(_ errorMessage: String) {
        BalanceErrorLabel.isHidden = false
        BalanceErrorLabel.text = errorMessage
    }
    
    
    func hideBalanceAmountErrorLabel() {
        BalanceErrorLabel.isHidden = true
    }
    
    func showErrorAlert(errorMessage: String) {
        
        self.showAlertWithOk(alertTitle: "Error", message: errorMessage, actionTitle: "Ok")
        
    }
}
