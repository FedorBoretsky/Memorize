//
//  GamesStore.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 14.06.2021.
//

import Foundation
import Combine
import SwiftUI

class ThemesStore: ObservableObject {
    
    struct ThemeStoreItem: Identifiable {
        var theme: Theme
        var gameViewModel: EmojiiMemoryGameVM
        var id: UUID { theme.id }
        
        init(theme: Theme){
            self.theme = theme
            self.gameViewModel = EmojiiMemoryGameVM(theme: theme)
        }
        
        init(gameViewModel: EmojiiMemoryGameVM){
            self.theme = gameViewModel.theme
            self.gameViewModel = gameViewModel
        }
        
    }
    
    @Published var items: [UUID:ThemeStoreItem]  // TODO: Private?
    
    private func addItem(_ item: ThemeStoreItem) {
        items[item.id] = item
    }
    
    func makeNewTheme() -> Theme {
        let newTheme = Theme.makeNewThemeTemplate()
        let newStoreItem = ThemeStoreItem(theme: newTheme)
        self.addItem(newStoreItem)
        return newTheme
    }
    
    var itemsSortedByName: [ThemeStoreItem] {
        items.values.sorted { $0.theme.name < $1.theme.name }
    }
    
    private static let userDefaultsKey = "ThemeStore"

    init() {
        self.items = [:]
        
        // Trying to read saved data.
        if let readedArray = UserDefaults.standard.array(forKey: Self.userDefaultsKey) {
            for rawData in readedArray{
                if let json = rawData as? Data {
                    if let gameViewModel = EmojiiMemoryGameVM(json: json) {
                        addItem(ThemeStoreItem(gameViewModel: gameViewModel))
                    }
                }
            }
        }
        
        // If something went wrong use the default set of themes.
        if items.isEmpty {
            Self.themeStarterPack.forEach { self.addItem(ThemeStoreItem(theme: $0)) }
        }
        
        //  Setup autosave
        autosave = $items.sink(receiveValue: { value in Self.saveAll(value)})
        
        
    }
    
    private var autosave: Cancellable? = nil
    
    func bindingToTheme(_ theme: Theme) -> Binding<Theme> {
        // TODO: - Is it possible to remove one theme while editing another?
        return Binding<Theme>(
            get: {
                self.items[theme.id]!.theme
            },
            set: {
                // Reset game for changed theme
                self.items[theme.id] = ThemesStore.ThemeStoreItem(theme: $0)
            }
        )
    }
    

    
    static func saveAll(_ recieved: [UUID:ThemeStoreItem]) {
        var savedArray = [Data]()
        for (_, item) in recieved {
            if let data = item.gameViewModel.json {
                savedArray.append(data)
            }
        }
        UserDefaults.standard.set(savedArray, forKey: Self.userDefaultsKey)
    }
        
    func removeItemWithId(_ id: UUID) {
        items[id] = nil
    }
    
}
