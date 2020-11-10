//
//  Array+Only.swift
//  Memorize
//
//  Created by Fedor Boretsky on 10.11.2020.
//

import Foundation

extension Array {
    var only: Element?  {
        count == 1 ? first : nil
    }
}
