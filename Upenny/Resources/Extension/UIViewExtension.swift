//
//  Extensions.swift
//  Upenny
//
//  Created by mohamedSliem on 8/12/22.
//

import UIKit

extension UIView{
    
    func viewStretchAnimatation(){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { finished in
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
            }
        })
    }
    
    
    var height : CGFloat {
         return frame.size.height
     }
     var width : CGFloat  {
         return frame.size.width
     }
     var left : CGFloat {
         return frame.origin.x
     }
     var right : CGFloat {
         return left + width
     }
     var top : CGFloat {
         return frame.origin.y
     }
     var bottom : CGFloat{
         return top + height
     }
     
}
