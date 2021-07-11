//
//  ThemesStarterPack.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 14.06.2021.
//

import SwiftUI


extension Theme {
    
    static let exampleHalloween = Theme(name: "Halloween",
              emojis: "👻🎃🕷🧙‍♀️🧹🕯🦇🌗🍭🧛🏻👀🙀",
              pairsToShow: 7,
              fill: [UIColor(#colorLiteral(red: 0.998834908, green: 0.2302215695, blue: 0.1895241439, alpha: 1)).rgb, UIColor(Color.orange).rgb, UIColor(#colorLiteral(red: 1, green: 0.7764705882, blue: 0, alpha: 1)).rgb])
    
    static func makeNewThemeTemplate() -> Theme {
        Theme(name: "Untitled",
              emojis: "🎱🎛🖤🐜",
              pairsToShow: 4,
              fill: [UIColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).rgb])
    }
}


extension ThemesStore {
    
    static let themeStarterPack: [Theme] = [
        
        Theme.exampleHalloween,
        
        Theme(name: "Flags",
              emojis: "🇦🇹🇩🇰🇨🇱🇨🇿🇨🇦🇬🇱🇬🇷🇱🇷🇺🇸🏴󠁧󠁢󠁥󠁮󠁧󠁿🇹🇿",
              pairsToShow: 5,
              fill: [UIColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).rgb]),
        
        Theme(name: "Beach",
              emojis: "🏝🏖⛵️🤿🎣🚣‍♀️⚓️🚤🌞🪁🏊‍♂️",
              pairsToShow: 5,
              fill: [UIColor(#colorLiteral(red: 0.9686274529, green: 0.7668460586, blue: 0.3002265522, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.5310901402, green: 0.8380914645, blue: 0.9686274529, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.3248517906, green: 0.7765617937, blue: 0.9686274529, alpha: 1)).rgb, UIColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).rgb]),
        
        Theme(name: "Red",
              emojis: "🏓🚗🚒⛽️☎️🧲🎈📍⛔️‼️♥️🍎🍓🍄",
              pairsToShow: 5,
              fill: [UIColor(#colorLiteral(red: 0.998834908, green: 0.2302215695, blue: 0.1895241439, alpha: 1)).rgb]),
        
        Theme(name: "Plants",
              emojis: "🌵🌳🍀💐🌻🌹🌱🌿🌴🌲",
              pairsToShow: 7,
              fill: [UIColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).rgb]),
        
        Theme(name: "Office",
              emojis: "💻🖥🖨⌨️📞🗄📁🗂📈🗃📥📤📔📋📎✂️🖍",
              pairsToShow: 4,
              fill: [UIColor(Color.gray).rgb]),
    ]
    
}
