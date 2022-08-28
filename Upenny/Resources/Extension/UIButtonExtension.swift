//
//  UIButtonExtension.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import UIKit

extension UIButton {
    
    func roundButtonWithShadows(cornerRadius: CGFloat? = 0, shadowRadius: CGFloat? = 0, shadowOpicity: Float? = 0.5, shadowOffset: CGSize? = .zero, shadowColor: UIColor? = .black){
        
        self.layer.cornerRadius = cornerRadius!
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowRadius = shadowRadius!
        self.layer.shadowOpacity = shadowOpicity!
        self.layer.shadowOffset = shadowOffset ?? .zero
        
    }
}
