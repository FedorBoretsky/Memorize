//
//  GamesStore.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 14.06.2021.
//

import Foundation

class ThemesStore: ObservableObject {
    
    struct ThemeStoreItem: Identifiable {
        var theme: Theme { gameViewModel.theme }
        var gameViewModel: EmojiiMemoryGameVM
        var id: UUID { theme.id }
        
        init(theme: Theme){
            self.gameViewModel = EmojiiMemoryGameVM(theme: theme)
        }
    }
    
    @Published var items: [ThemeStoreItem]
    
    init() {
        self.items = Self.themeStarterPack.map { ThemeStoreItem(theme: $0) }
    }
    
    func removeItemWithId(_ id: UUID) {
        if let index = items.firstIndex(where: { id == $0.id }){
            items.remove(at: index)
        }
    }
    
}
