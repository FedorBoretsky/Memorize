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
    
    private struct PersistentInnerFormat: Codable {
        let themeJSON: Data?
        let gameModelJSON: Data?
    }
    
    private static let userDefaultsKey = "ThemeStore"
    
    private func saveAll() {
        var savedArray = [PersistentInnerFormat]()
        
        for item in items {
            let jsonTuple = item.gameViewModel.json
            let newSavedItem = PersistentInnerFormat(themeJSON: jsonTuple.themeJSON,
                                                     gameModelJSON: jsonTuple.gameModelJSON)
            savedArray.append(newSavedItem)
        }
        
        UserDefaults.standard.setValue(savedArray, forKey: Self.userDefaultsKey)
        
    }
    
    
    func removeItemWithId(_ id: UUID) {
        if let index = items.firstIndex(where: { id == $0.id }){
            items.remove(at: index)
        }
    }
    
}
