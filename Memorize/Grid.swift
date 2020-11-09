//
//  Grid.swift
//  Memorize
//
//  Created by Fedor Boretsky on 06.11.2020.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var itemš: [Item]
    var viewForItem: (Item) -> ItemView
    
    init (_ itemš: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.itemš = itemš
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: self.itemš.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(itemš) { item in
            bodyOfItem(for: item, in: layout)
        }
    }
    
    func bodyOfItem(for item: Item, in layout: GridLayout) -> some View {
        let index = self.index(of: item)
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
    func index(of item: Item) -> Int {
        for index in 0..<itemš.count {
            if itemš[index].id == item.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
}

