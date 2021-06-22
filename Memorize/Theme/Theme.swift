//
//  Theme.swift
//  Memorize
//
//  Created by Fedor Boretsky on 11.11.2020.
//

import SwiftUI


struct Theme: Codable, Identifiable {
    let name: String
    let emojis: [String]
    let pairsToShow: Int
    let fill: [UIColor.RGB]
    let id: UUID
}


extension Theme {
    
    // Emojis in the single string.
    init (name: String, emojis: String, pairsToShow: Int, fill: [UIColor.RGB], id: UUID) {
        self.init(name: name,
                  emojis: emojis.map{ String($0) },
                  pairsToShow: pairsToShow,
                  fill: fill,
                  id: id)
    }
    
    // Auto ID + Emoji in the single string.
    init (name: String, emojis: String, pairsToShow: Int, fill: [UIColor.RGB]) {
        self.init(name: name,
                  emojis: emojis,
                  pairsToShow: pairsToShow,
                  fill: fill,
                  id: UUID())
    }
    
}

