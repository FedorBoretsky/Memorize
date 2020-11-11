//
//  EmojiiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import SwiftUI

class EmojiiMemoryGameVM: ObservableObject {
    
    @Published private var model: MemoryGameModel<String> = createMemoryGame()
    
    static let possibleThemes¨: [Theme] = [
        Theme(name: "Halloween", emojis¨: "👻🎃🕷🧙‍♀️🧹🕯🦇🌗🍭🧛🏻👀🙀", numberOfPairsToShow: nil, color: .orange),
        Theme(name: "Flags", emojis¨: "🇦🇹🇩🇰🇨🇱🇨🇿🇨🇦🇬🇱🇬🇷🇱🇷🇺🇸🏴󠁧󠁢󠁥󠁮󠁧󠁿🇹🇿", numberOfPairsToShow: 4, color: .init(white: 0.75)),
    ]
    
    static func createMemoryGame() -> MemoryGameModel<String> {
        let theme = possibleThemes¨[1]//.randomElement()!
        let emojiiStore = theme.emojis¨.shuffled()
        let pairsCount = theme.numberOfPairsToShow ?? Int.random(in: 2...min(5,theme.emojis¨.count))
//        themeC
        print(emojiiStore)
        print(pairsCount)
        themeColor = theme.color
        return MemoryGameModel<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
            return emojiiStore[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards¨: Array<MemoryGameModel<String>.Card> {
        model.cards¨
    }
    
    // MARK: - Access to the Theme
    
    static private var themeColor = Color.clear
    
    var themeColor: Color {
        Self.themeColor
    }
    
    
    // MARK: - Intent(s)
    
    /// Ask model to change a state of a card between "Face Up" and "Cover Up".
    ///
    /// - Parameter card: A card wich state we want to change.
    func choose(card: MemoryGameModel<String>.Card) {
        model.choose(card: card)
    }
    
}
