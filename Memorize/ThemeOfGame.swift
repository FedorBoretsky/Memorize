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
    let numberOfPairsToShow: Int?  // If nil, then select random number to show
    let color: Color
}

extension Theme {
    init (name: String, emojis¨: String, numberOfPairsToShow: Int? = nil, color: Color) {
        self.init(name: name, emojis¨: emojis¨.map{ String($0) }, numberOfPairsToShow: numberOfPairsToShow, color: color)
    }
}

