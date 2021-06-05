//
//  Data+utf8.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 06.06.2021.
//

import Foundation

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
