//
//  EmojiiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import SwiftUI

class EmojiiMemoryGameVM: ObservableObject {
    
    @Published private var model: MemoryGameModel<String> = createMemoryGame()
    
    private static let possibleThemes¨: [Theme] = [
        Theme(name: "Halloween", emojis¨: "👻🎃🕷🧙‍♀️🧹🕯🦇🌗🍭🧛🏻👀🙀", pairsToShow: nil, fill: [.red, .orange, Color(#colorLiteral(red: 1, green: 0.7764705882, blue: 0, alpha: 1))]),
        Theme(name: "Flags", emojis¨: "🇦🇹🇩🇰🇨🇱🇨🇿🇨🇦🇬🇱🇬🇷🇱🇷🇺🇸🏴󠁧󠁢󠁥󠁮󠁧󠁿🇹🇿", pairsToShow: 5, fill: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]),
        Theme(name: "Beach", emojis¨: "🏝🏖⛵️🤿🎣🚣‍♀️⚓️🚤🌞🪁🏊‍♂️", pairsToShow: 4, fill: [Color(#colorLiteral(red: 0.9686274529, green: 0.7668460586, blue: 0.3002265522, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.5310901402, green: 0.8380914645, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3248517906, green: 0.7765617937, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]),
        Theme(name: "Red", emojis¨: "🏓🚗🚒⛽️☎️🧲🎈📍⛔️‼️♥️🍎🍓🍄", pairsToShow: 5, fill: [.red]),
        Theme(name: "Plants", emojis¨: "🌵🌳🍀💐🌻🌹🪴🌿🌴🌲", pairsToShow: nil, fill: [Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))]),
        Theme(name: "Office", emojis¨: "💻🖥🖨⌨️📞🗄📁🗂📈🗃📥📤📔📋📎✂️🖍", pairsToShow: 4, fill: [.gray]),
    ]
    
    static private var currentThemeIndex: Int?
    static private var prevThemeIndex: Int?
    static private var prevPrevThemIndex: Int?
    
    private static func selectTheme() -> Int {
        prevPrevThemIndex = prevThemeIndex
        prevThemeIndex = currentThemeIndex
        while currentThemeIndex == prevThemeIndex || currentThemeIndex == prevPrevThemIndex {
            currentThemeIndex = Int.random(in: 0..<possibleThemes¨.count)
        }
        return currentThemeIndex!
    }
    
    private static func createMemoryGame() -> MemoryGameModel<String> {
        let theme = possibleThemes¨[selectTheme()]
        let emojiiStore = theme.emojis¨.shuffled()
        let pairsCount = theme.pairsToShow ?? Int.random(in: 2...(theme.emojis¨.count-1))
        return MemoryGameModel<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
            return emojiiStore[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards¨: Array<MemoryGameModel<String>.Card> {
        model.cards¨
    }
    
    var score: Double {
        model.score
    }

    var bonus: Double {
        model.bonus
    }

    
    // MARK: - Access to the Theme
    
    
    var themeColor: Color {
        return Self.possibleThemes¨[Self.currentThemeIndex!].fill.last!
    }

    var themeFill: [Color] {
        Self.possibleThemes¨[Self.currentThemeIndex!].fill
    }

    var themeName: String {
        Self.possibleThemes¨[Self.currentThemeIndex!].name
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
        model = Self.createMemoryGame()
    }
    
}
