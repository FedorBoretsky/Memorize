//
//  ThemesStore.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 14.06.2021.
//

import Foundation

class ThemesStore {
    var themes: [Theme]
    
    init() {
        themes = Self.themesStarterPack
    }
}
