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
        Theme(name: "Halloween", emojis¨: "👻🎃🕷🧙‍♀️🧹🕯🦇🌗🍭🧛🏻👀🙀", pairsToShow: 7, fill: [UIColor(#colorLiteral(red: 0.998834908, green: 0.2302215695, blue: 0.1895241439, alpha: 1)).rgb, UIColor(Color.orange).rgb, UIColor(#colorLiteral(red: 1, green: 0.7764705882, blue: 0, alpha: 1)).rgb]),
        Theme(name: "Flags", emojis¨: "🇦🇹🇩🇰🇨🇱🇨🇿🇨🇦🇬🇱🇬🇷🇱🇷🇺🇸🏴󠁧󠁢󠁥󠁮󠁧󠁿🇹🇿", pairsToShow: 5, fill: [UIColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).rgb]),
        Theme(name: "Beach", emojis¨: "🏝🏖⛵️🤿🎣🚣‍♀️⚓️🚤🌞🪁🏊‍♂️", pairsToShow: 5, fill: [UIColor(#colorLiteral(red: 0.9686274529, green: 0.7668460586, blue: 0.3002265522, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.5310901402, green: 0.8380914645, blue: 0.9686274529, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.3248517906, green: 0.7765617937, blue: 0.9686274529, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).rgb]),
        Theme(name: "Red", emojis¨: "🏓🚗🚒⛽️☎️🧲🎈📍⛔️‼️♥️🍎🍓🍄", pairsToShow: 5, fill: [UIColor(#colorLiteral(red: 0.998834908, green: 0.2302215695, blue: 0.1895241439, alpha: 1)).rgb]),
        Theme(name: "Plants", emojis¨: "🌵🌳🍀💐🌻🌹🌱🌿🌴🌲", pairsToShow: 7, fill: [UIColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).rgb]),
        Theme(name: "Office", emojis¨: "💻🖥🖨⌨️📞🗄📁🗂📈🗃📥📤📔📋📎✂️🖍", pairsToShow: 4, fill: [UIColor(Color.gray).rgb]),
    ]
    
    static private var currentThemeIndex: Int?
    static private var prevThemeIndex: Int?
    static private var prevPrevThemIndex: Int?
    
    private static func selectTheme() -> Int {
        // TODO: Need comments
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
        let pairsCount = theme.pairsToShow
        // Assignment V required task 2
        //
        print("JSON representation of the theme:\n\(theme.json?.utf8 ?? "nil")")
        //
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

//    var bonus: Double {
//        model.bonus
//    }

    
    // MARK: - Access to the Theme
    
    
    var themeColor: Color {
        return Color(Self.possibleThemes¨[Self.currentThemeIndex!].fill.last!)
    }

    var themeFill: [Color] {
        Self.possibleThemes¨[Self.currentThemeIndex!].fill.map{ Color($0) }
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
