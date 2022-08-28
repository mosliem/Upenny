//
//  FloatExtension.swift
//  Upenny
//
//  Created by mohamedSliem on 8/16/22.
//

import UIKit

extension Float {
    
  
    var ZeroDots: String {
           return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
        
    }
    

}
