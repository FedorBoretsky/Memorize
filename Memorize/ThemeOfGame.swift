//
//  ThemeOfGame.swift
//  Memorize
//
//  Created by Fedor Boretsky on 11.11.2020.
//

import SwiftUI


struct Theme: Codable {
    let name: String
    let emojis¨: [String]
    let pairsToShow: Int
    let fill: [UIColor.RGB]
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
}

extension Theme {
    init (name: String, emojis¨: String, pairsToShow: Int, fill: [UIColor.RGB]) {
        self.init(name: name, emojis¨: emojis¨.map{ String($0) }, pairsToShow: pairsToShow, fill: fill)
    }
}

