//
//  AddNoteProtocols.swift
//  Upenny
//
//  Created by mohamedSliem on 8/13/22.

protocol AddNoteView: class {
    
    var presenter: AddNoteViewPresenter! { get set }
    func enableSaveButton()
    func disableSaveButton()
    func setNotePlaceholder()
    func setNoteTextConfiuration()
    func dismissWithNoteSave(with note: String?)
    func dismissNoteView()
    
}


protocol AddNoteViewPresenter {
    
    var view: AddNoteView? { get set }
    init(view: AddNoteView?)
    func textDidChange(_ text: String)
    func textEditingDidBegin(_ text: String)
    func textEditingDidEnd(_ text: String)
    func cancelPressed()
    func savePressed(_ text: String)
    
}

protocol AddNoteDelegate: class {
    
    func saveNote(text: String)

}
