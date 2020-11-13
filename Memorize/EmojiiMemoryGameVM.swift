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
        Theme(name: "Flags", emojis¨: "🇦🇹🇩🇰🇨🇱🇨🇿🇨🇦🇬🇱🇬🇷🇱🇷🇺🇸🏴󠁧󠁢󠁥󠁮󠁧󠁿🇹🇿", numberOfPairsToShow: 5, color: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))),
        Theme(name: "Beach", emojis¨: "🏝🏖⛵️🤿🎣🚣‍♀️⚓️🚤🌞🪁🏊‍♂️", numberOfPairsToShow: 4, color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))),
        Theme(name: "Red", emojis¨: "🏓🚗🚒⛽️☎️🧲🎈📍⛔️‼️♥️🍎🍓🍄", numberOfPairsToShow: 5, color: .red),
        Theme(name: "Plants", emojis¨: "🌵🌳🍀💐🌻🌹🪴🌿🌴🌲", numberOfPairsToShow: nil, color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))),
        Theme(name: "Office", emojis¨: "💻🖥🖨⌨️📞🗄📁🗂📈🗃📥📤📔📋📎✂️🖍", numberOfPairsToShow: 4, color: .gray),
    ]
    
    static private var currentThemeIndex, prevThemeIndex, prevPrevThemIndex: Int?
    
    static func selectTheme() -> Int {
        prevPrevThemIndex = prevThemeIndex
        prevThemeIndex = currentThemeIndex
        while currentThemeIndex == prevThemeIndex || currentThemeIndex == prevPrevThemIndex {
            currentThemeIndex = Int.random(in: 0..<possibleThemes¨.count)
        }
        return currentThemeIndex!
    }
    
    static func createMemoryGame() -> MemoryGameModel<String> {
        let theme = possibleThemes¨[selectTheme()]
        let emojiiStore = theme.emojis¨.shuffled()
        let pairsCount = theme.numberOfPairsToShow ?? Int.random(in: 2...min(5,theme.emojis¨.count))
        return MemoryGameModel<String>(numberOfPairsOfCards: pairsCount) { pairIndex in
            return emojiiStore[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards¨: Array<MemoryGameModel<String>.Card> {
        model.cards¨
    }
    
    // MARK: - Access to the Theme
    
    
    var themeColor: Color {
        Self.possibleThemes¨[Self.currentThemeIndex!].color
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
