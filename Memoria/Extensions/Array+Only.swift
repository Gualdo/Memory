//
//  Array+Only.swift
//  Memoria
//
//  Created by De La Cruz, Eduardo on 18/07/2020.
//  Copyright © 2020 De La Cruz, Eduardo. All rights reserved.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}
