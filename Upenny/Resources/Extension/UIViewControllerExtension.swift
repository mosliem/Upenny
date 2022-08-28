//
//  UIViewControllerExtension.swift
//  Upenny
//
//  Created by mohamedSliem on 8/17/22.
//

import UIKit

extension UIViewController{
    
    func showAlertWithOk(alertTitle: String,message: String,actionTitle: String){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    
    }
    
    func showYesNoAlert(alertTitle: String,message: String, yesHandler: ((UIAlertAction) -> Void)?, noHandler: ((UIAlertAction) -> Void)?){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: yesHandler))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: noHandler))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    
    }
}
