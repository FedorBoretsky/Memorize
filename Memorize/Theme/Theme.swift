//
//  Theme.swift
//  Memorize
//
//  Created by Fedor Boretsky on 11.11.2020.
//

import SwiftUI

public typealias Fill = [UIColor.RGB]

struct Theme: Codable, Identifiable {
    var name: String
    var emojis: [String] {
        willSet {
            if newValue.count < pairsToShow {
                pairsToShow = newValue.count
            }
        }
    }
    var pairsToShow: Int
    var fill: Fill
    let id: UUID
    var hiddenEmojis: Set<String> = Set()
    
    var activeEmojis: [String] {
        emojis.compactMap{ hiddenEmojis.contains($0) ? nil : $0}
    }

}

// Convenient initializers
extension Theme {
    
    // Emojis in the single string.
    init (name: String, emojis: String, pairsToShow: Int, fill: Fill, id: UUID) {
        self.init(name: name,
                  emojis: emojis.map{ String($0) },
                  pairsToShow: pairsToShow,
                  fill: fill,
                  id: id)
    }
    
    // Auto ID + Emoji in the single string.
    init (name: String, emojis: String, pairsToShow: Int, fill: Fill) {
        self.init(name: name,
                  emojis: emojis,
                  pairsToShow: pairsToShow,
                  fill: fill,
                  id: UUID())
    }
    
}


// Edit emoji collection
extension Theme {
    
    var minimumEmojiCount: Int { 2 }
    var isMinimumEmojiCount: Bool { emojis.count == minimumEmojiCount }
        
    mutating func removeEmoji(_ emoji: String) {
        if emojis.count > minimumEmojiCount {
            emojis.removeAll { $0 == emoji }
        }
    }
    
    mutating func toogleVisibilityEmoji(_ emoji: String){
        if hiddenEmojis.contains(emoji) {
            hiddenEmojis.remove(emoji)
        } else {
            hiddenEmojis.insert(emoji)
        }
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

