//
//  AddNoteVC.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import UIKit

class AddNoteVC: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteView: UIView!
    
    var presenter: AddNoteViewPresenter!
    weak var addNoteDelegate: AddNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureViews()
        presenter = AddNoteVCPresenter(view: self)

    }
    
    private func configureViews(){
        
        configureSaveButtonView()
        configureCancelButtonView()
        configureNoteView()
        configureNoteTextView()
       configureTextViewToolbar()
    }
    
    private func configureNoteTextView(){
        
        noteTextView.text = "Add your note"
        noteTextView.textColor = .lightGray
        noteTextView.delegate = self
        
    }
    
    
    @objc func dismissMyKeyboard(){
        noteTextView.endEditing(true)
    }
    
    private func configureNoteView(){
        
        noteView.layer.cornerRadius = 15
        noteView.layer.masksToBounds = false
        
    }
    
    private func configureSaveButtonView(){
        
        saveButton.roundButtonWithShadows(
            cornerRadius: 10,
            shadowRadius: 4,
            shadowOpicity: 0.3,
            shadowOffset: CGSize(width: 0, height: 2),
            shadowColor: .systemBlue
        )
    }
    
    private func configureCancelButtonView(){
        
        cancelButton.roundButtonWithShadows(
            cornerRadius: 10,
            shadowRadius: 4,
            shadowOpicity: 0.3,
            shadowOffset: CGSize(width: 0, height: 2),
            shadowColor: .systemRed
        )
        
    }
    
    private func configureTextViewToolbar(){
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:  .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissMyKeyboard))
      
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        self.noteTextView.inputAccessoryView = toolbar
    
    }
    
    @IBAction func didPressSaveButton(_ sender: UIButton) {
        addNoteDelegate?.saveNote(text: noteTextView.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressCancelButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
}

