//
//  GamesStore.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 14.06.2021.
//

import Foundation

class ThemesStore {
    
    struct ThemeStoreItem: Identifiable {
        var theme: Theme
        var gameViewModel: EmojiiMemoryGameVM
        let id: UUID
        
        init(theme: Theme){
            self.theme = theme
            gameViewModel = EmojiiMemoryGameVM(theme: theme)
            id = theme.id
        }
    }
    
    var items: [ThemeStoreItem]
    
    init() {
        self.items = Self.themeStarterPack.map { ThemeStoreItem(theme: $0) }
    }
}
