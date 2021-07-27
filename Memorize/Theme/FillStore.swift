//
//  FillStore.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 27.07.2021.
//

import SwiftUI

class FillStore {
    static let shared = FillStore()
    
    var items = Set<Fill>()
    
    init() {
        //
        // Add predefined SwiftUI colors.
        items.insert([UIColor(Color.pink).rgb])
//        items.insert([UIColor(Color.green).rgb])  // Similar to fill from themeStarterPack.
        items.insert([UIColor(Color.gray).rgb])
        items.insert([UIColor(Color.black).rgb])
        items.insert([UIColor(Color.blue).rgb])
        items.insert([UIColor(Color.orange).rgb])
        items.insert([UIColor(Color.pink).rgb])
        items.insert([UIColor(Color.purple).rgb])
        items.insert([UIColor(Color.yellow).rgb])
//        items.insert([UIColor(Color.red).rgb])   // Similar to fill from themeStarterPack.
//        items.insert([UIColor(Color.white).rgb])   // No sense to use white for cover.
    }
    
    func gatherFillsFromThemeStore(_ themeStore: ThemesStore) {
        
        // Get fills from default collection of theme.
        for theme in ThemesStore.themeStarterPack {
            items.insert(theme.fill)
        }
        
        // Collect fills from actual themes.
        for themeStoreItem in themeStore.items {
            items.insert(themeStoreItem.value.theme.fill)
        }
    }
    
    
}
