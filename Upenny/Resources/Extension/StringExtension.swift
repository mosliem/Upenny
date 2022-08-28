//
//  StringExtension.swift
//  Upenny
//
//  Created by mohamedSliem on 8/17/22.
//

import UIKit

extension String{
    
    var stringToFloat: Float {
        
        let numberFormatter = NumberFormatter()
        let floatNumber = numberFormatter.number(from: self)?.floatValue ?? 0
        return floatNumber
        
    }
    
    func emojiToIconImage(size: CGFloat = 98) -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: size)
        
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        UIColor.clear.set()
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize))
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    
    
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    
    mutating func trimmingLeadingTrailingSpaces(){
        
        
        for ch in self {
            
            if ch != " "{
                break
            }
            self.removeFirst()
        }
        
        for i in (0 ... length - 1).reversed(){
            
            if self[i] != " "{
                break
            }
            self.removeLast()
        }
        
    }
    
}
