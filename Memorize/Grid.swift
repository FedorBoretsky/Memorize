//
//  Grid.swift
//  Memorize
//
//  Created by Fedor Boretsky on 06.11.2020.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items¨: [Item]
    var desiredAspectRatio: Double
    var viewForItem: (Item) -> ItemView
    
    init (_ items¨: [Item], desiredAspectRatio: Double = 1, viewForItem: @escaping (Item) -> ItemView) {
        self.items¨ = items¨
        self.desiredAspectRatio = desiredAspectRatio
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: self.items¨.count, nearAspectRatio: desiredAspectRatio, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items¨) { item in
            bodyOfItem(for: item, in: layout)
        }
    }
    
    func bodyOfItem(for item: Item, in layout: GridLayout) -> some View {
        let index = items¨.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
}

