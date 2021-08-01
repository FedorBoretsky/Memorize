//
//  EmojiiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import SwiftUI

class EmojiiMemoryGameVM: ObservableObject {
    
    
    public typealias GameModel = MemoryGameModel<String>
    @Published private var model: GameModel
    private(set) var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        self.model = Self.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme, isShuffle: Bool = true) -> GameModel {
        var emojiiStore = theme.activeEmojis
        let pairsCount = theme.pairsToShow
        if isShuffle {
            emojiiStore = emojiiStore.shuffled()
        }
        return MemoryGameModel<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
            return emojiiStore[pairIndex]
        }
    }
    
    // MARK: - JSON support
    
    private struct SavinContainer: Codable {
        let theme: Theme
        let model: GameModel
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(SavinContainer(theme: theme, model: model))
    }
    
    init? (json: Data?) {
        if json != nil,
           let readData = try? JSONDecoder().decode(SavinContainer.self, from: json!) {
            self.theme = readData.theme
            self.model = readData.model
        } else {
            return nil
        }
    }

    
    // MARK: - Sample For ThemeChoser
    
    static func themeCardsSample(theme: Theme) -> Array<MemoryGameModel<String>.Card> {
        var cards = Array<MemoryGameModel<String>.Card>()
        var id = 1
        for emoji in theme.activeEmojis {
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
