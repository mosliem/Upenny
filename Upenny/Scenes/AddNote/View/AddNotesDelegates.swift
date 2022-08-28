//
//  AddNotesDelegates.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import UIKit


extension AddNoteVC: UITextViewDelegate{
    
    
    //Handle text view placeholder
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        presenter?.textEditingDidBegin(textView.text)
     
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        presenter?.textEditingDidEnd(textView.text)
        
    }
 
    // handle the avaliablity of save button
    
    func textViewDidChange(_ textView: UITextView) {

        presenter?.textDidChange(textView.text)

    }
    
  
}


extension AddNoteVC: AddNoteView{
    
    func enableSaveButton() {
        
        saveButton.isEnabled = true
        saveButton.alpha = 1.0
    
    }
    
    func disableSaveButton() {
        
        saveButton.isEnabled = false
        saveButton.alpha = 0.4
    
    }
    
    func setNotePlaceholder() {
        
        noteTextView.text = "Add your note"
        noteTextView.textColor = .lightGray
    
    }
    
    func setNoteTextConfiuration() {
        
        noteTextView.text = ""
        noteTextView.textColor = .black
        noteTextView.font = .systemFont(ofSize: 15, weight: .medium)
    
    }
    
 
    func dismissWithNoteSave(with note: String?) {
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func dismissNoteView() {
        
        self.dismiss(animated: true, completion: nil)
    
    }
}


