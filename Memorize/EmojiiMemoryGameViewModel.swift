//
//  EmojiiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import SwiftUI

class EmojiiMemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGameModel<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGameModel<String> {
        let emojiiStore: Array<String> = ["👻", "🎃", "🕷", "🧙‍♀️", "🧹", "🕯",
                                          "🦇", "🌗", "🍭", "🧛🏻", "👀", "🙀"].shuffled()
        let pairsCount = Int.random(in: 2...5)
        return MemoryGameModel<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
            return emojiiStore[pairIndex]
        }
    }
    
    // MARK: - Acces to the Model
    
    var cardš: Array<MemoryGameModel<String>.Card> {
        model.cardsBunch
    }
    
    // MARK: - Intent(s)
    
    /// Ask model to change a state of a card between "Face Up" and "Cover Up".
    ///
    /// - Parameter card: A card wich state we want to change.
    func choose(card: MemoryGameModel<String>.Card) {
        model.choose(card: card)
    }
    
}
