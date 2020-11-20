//
//  ThemeOfGame.swift
//  Memorize
//
//  Created by Fedor Boretsky on 11.11.2020.
//

import SwiftUI


struct Theme {
    let name: String
    let emojis¨: [String]
    let pairsToShow: Int?  // If nil, then select random number to show
    let fill: [Color]
}

extension Theme {
    init (name: String, emojis¨: String, pairsToShow: Int? = nil, fill: [Color]) {
        self.init(name: name, emojis¨: emojis¨.map{ String($0) }, pairsToShow: pairsToShow, fill: fill)
    }
}

