//
//  Theme.swift
//  Memorize
//
//  Created by Fedor Boretsky on 11.11.2020.
//

import SwiftUI


struct Theme: Codable, Identifiable {
    var name: String
    var emojis: [String]
    let pairsToShow: Int
    let fill: [UIColor.RGB]
    let id: UUID
}

// Convenient initializers
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

// Edit emoji collection
extension Theme {
    
    mutating func removeEmoji(_ emoji: String) {
        emojis.removeAll { $0 == emoji }
    }
    
    mutating func addEmojis(string: String) {
        let removedWhitespaces = string.replacingOccurrences(of: "\\s*", with: "", options: [.regularExpression])
        for newEmoji in removedWhitespaces.reversed() {
            if !emojis.contains(String(newEmoji)) {
                emojis.insert(String(newEmoji), at: 0)
            }
        }
    }
}

