//
//  AddNoteViewPresenter.swift
//  Upenny
//
//  Created by mohamedSliem on 8/13/22.
//

import Foundation

class AddNoteVCPresenter: AddNoteViewPresenter {
  
    weak var view: AddNoteView?
    
    required init(view: AddNoteView?) {
        self.view = view
    }
    
    func textDidChange(_ text: String) {

        if !text.isEmpty{
            view?.enableSaveButton()
        }
        else{
            view?.disableSaveButton()
        }
    }
    
    func textEditingDidBegin(_ text: String){
     
        if text == "Add your note"{
            view?.setNoteTextConfiuration()
        }
    }
    
    func textEditingDidEnd(_ text: String) {
        
        if text.isEmpty{
            view?.setNotePlaceholder()
            view?.disableSaveButton()
        }
    }
    
    func cancelPressed() {
        
        view?.dismissNoteView()
    
    }
    
    func savePressed(_ text: String) {
        
        view?.dismissWithNoteSave(with: text)
    }

    
}
