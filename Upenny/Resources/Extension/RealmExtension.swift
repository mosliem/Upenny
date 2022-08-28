//
//  RealmExtension.swift
//  Upenny
//
//  Created by mohamedSliem on 8/19/22.
//

import RealmSwift

extension Results {
    
    // Genertic function to convert Results list to an array of the same Results type
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap {
            $0 as? T
        }
    }
}

extension Array {
    
    static func is2dEmpty(array: [[Element]]) -> Bool{
        
        for element in array {
            
            if !element.isEmpty{
                return false
            }
        }
        return true
    }
}
