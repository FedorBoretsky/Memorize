//
//  EmojiiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import SwiftUI

class EmojiiMemoryGameViewModel {
    private var model: MemoryGameModel<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGameModel<String> {
        let emojiiStore: Array<String> = ["👻", "🎃", "🕷", "🧙‍♀️", "🧹"]
        let pairsCount = Int.random(in: 2...5)
        return MemoryGameModel<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
            return emojiiStore[pairIndex]
        }
    }
    
    // MARK: - Acces to the Model
    
    var cardsBunch: Array<MemoryGameModel<String>.Card> {
        model.cardsBunch
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGameModel<String>.Card) {
        model.choose(card: card)
    }
}
