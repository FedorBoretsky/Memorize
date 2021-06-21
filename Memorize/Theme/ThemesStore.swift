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
    
    init() {
        self.items = []
        
        // Trying read saved data.
        if let readedArray = UserDefaults.standard.array(forKey: Self.userDefaultsKey) {
            for rawData in readedArray{
                if let typedData = rawData as? PersistentInnerFormat {
                    let themeJSON = typedData.themeJSON
                    let gameModelJSON = typedData.gameModelJSON
                    if let gameViewModel = EmojiiMemoryGameVM(themeJSON: themeJSON,
                                                              gameModelJSON: gameModelJSON) {
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
    
    private struct PersistentInnerFormat: Codable {
        let themeJSON: Data?
        let gameModelJSON: Data?
    }
    
    private static let userDefaultsKey = "ThemeStore"
    
    func saveAll() {
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
