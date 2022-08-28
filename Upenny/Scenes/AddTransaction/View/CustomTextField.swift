//
//  CustomTextField.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import UIKit

class CustomTextField: UITextField{
    
   private var bottomLine = CALayer()
   private let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)

  
    
    func renderTextFeildLeftIcon(){
        
        self.leftViewMode = .always
        let image = UIImage().resizeImage(image: UIImage(named: "dollar-symbol")!, targetSize: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
        self.leftView = UIImageView(image: image)
        self.leftView?.tintColor = .lightGray
    }
    
    func renderBottomLine(width: CGFloat){
        
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
   
    }

    func updateBottomLineWidth(width: CGFloat){
        
        var width = width
        if width > 200 {
            width = 200
        }
        var newFrame = bottomLine.frame
        newFrame.size.width = width
        self.bounds.size.width = width
        bottomLine.frame = newFrame
        bottomLine.layoutIfNeeded()
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: padding)
      }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
