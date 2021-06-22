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
        
        init(gameViewModel: EmojiiMemoryGameVM){
            self.gameViewModel = gameViewModel
        }
        
    }
    
    @Published var items: [ThemeStoreItem]
    private static let userDefaultsKey = "ThemeStore"

    init() {
        self.items = []
        
        // Trying read saved data.
        if let readedArray = UserDefaults.standard.array(forKey: Self.userDefaultsKey) {
            for rawData in readedArray{
                if let json = rawData as? Data {
                    if let gameViewModel = EmojiiMemoryGameVM(json: json) {
                        items.append(ThemeStoreItem(gameViewModel: gameViewModel))
                    }
                }
            }
        }
        
        // If something went wrong use the default set of themes.
        if items.isEmpty {
            self.items = Self.themeStarterPack.map { ThemeStoreItem(theme: $0) }
        }
    }
    
    
    func saveAll() {
        var savedArray = [Data]()
        for item in items {
            if let data = item.gameViewModel.json {
                savedArray.append(data)
            }
        }
        UserDefaults.standard.set(savedArray, forKey: Self.userDefaultsKey)
    }
        
    func removeItemWithId(_ id: UUID) {
        if let index = items.firstIndex(where: { id == $0.id }){
            items.remove(at: index)
        }
    }
    
}
