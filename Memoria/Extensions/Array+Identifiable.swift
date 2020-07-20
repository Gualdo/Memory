//
//  Array+Identifiable.swift
//  Memoria
//
//  Created by De La Cruz, Eduardo on 18/07/2020.
//  Copyright © 2020 De La Cruz, Eduardo. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
