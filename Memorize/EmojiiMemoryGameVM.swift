//
//  EmojiiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import SwiftUI

class EmojiiMemoryGameVM: ObservableObject {
    
    private(set) var theme: Theme
    
    public typealias GameModel = MemoryGameModel<String>
    
    @Published private var model: GameModel
    
    
    init(theme: Theme) {
        self.theme = theme
        self.model = Self.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme, isShuffle: Bool = true) -> GameModel {
        var emojiiStore = theme.emojis
        let pairsCount = theme.pairsToShow

        if isShuffle {
            emojiiStore = emojiiStore.shuffled()
        }
        //
        // Assignment V required task 2
//        print("JSON representation of the theme:\n\(theme.json?.utf8 ?? "nil")")
        //
        //
        return MemoryGameModel<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
            return emojiiStore[pairIndex]
        }
    }
    
    // MARK: - Sample For ThemeChoser
    
    static func themeCardsSample(theme: Theme) -> Array<MemoryGameModel<String>.Card> {
        var cards = Array<MemoryGameModel<String>.Card>()
        var id = 1
        for emoji in theme.emojis {
            var faceUpCard = MemoryGameModel<String>.Card(content: String(emoji), id: id)
            faceUpCard.isFaceUp = true
            faceUpCard.bonusTimeLimit = 0
            cards.append(faceUpCard)
            id += 1
        }
        
        return cards
    }
    
    
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGameModel<String>.Card> {
        model.cards
    }
    
    var scoreTotal: Double {
        model.scoreTotal
    }

    var scoreMatchedReward: Double {
        model.scoreMatchedReward
    }

    var scoreMismatchedPenalty: Double {
        model.scoreMismatchedPenalty
    }

    var scoreSpeedAmplification: Double {
        model.scoreSpeedAmplification
    }
    

    // MARK: - Access to the Theme
    
    var themeName: String {
        theme.name
    }
    
    // Static variant for theme chooser.
    static func themeForegroundColor(theme: Theme) -> Color {
        return Color(theme.fill.last!)
    }
    
    var themeForegroundColor: Color {
        return Self.themeForegroundColor(theme: theme)
    }
    
    // Static variant for theme chooser.
    static func themeFill(theme: Theme) -> [Color] {
        return theme.fill.map{ Color($0) }
    }

    var themeFill: [Color] {
        Self.themeFill(theme: theme)
    }

    
    // MARK: - Intent(s)
    
    /// Ask model to change a state of a card between "Face Up" and "Cover Up".
    ///
    /// - Parameter card: A card wich state we want to change.
    func choose(card: MemoryGameModel<String>.Card) {
        model.choose(card: card)
    }
    
    /// Start new game
    ///
    func newGame() {
        model = Self.createMemoryGame(theme: theme)
    }
    
}
