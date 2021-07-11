//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 14.06.2021.
//

import SwiftUI

struct ThemeChooserView: View {
    
    @ObservedObject var themesStore = ThemesStore()
    
    @State private var newTheme: Theme?
    @State private var isThemeEditorShowing = false
    @State private var isListEditMode: EditMode = .inactive
    
//    @State var tt = Theme.exampleHalloween
    
    var body: some View {
        NavigationView{
            List{
                ForEach(themesStore.itemsSortedByName){ item in
                    NavigationLink(
                        destination: EmojiMemoryGameView(viewModel: item.gameViewModel)
                    ) {
                        ThemeChoserRow(theme: item.theme, isEdit: isListEditMode.isEditing)
                    }
                }
                .onDelete{ indexSet in
                    indexSet
                        .map{ index in themesStore.itemsSortedByName[index] }
                        .forEach{ storeItem in themesStore.removeItemWithId(storeItem.id)}
                }
            }
            .navigationTitle("Memorize")
            .navigationBarItems(
                leading:
                    // Create new theme
                    Button{
                        newTheme = themesStore.makeNewTheme()
                        isThemeEditorShowing = true
                    } label: {
                        Image(systemName: "plus.circle")
                    },
                trailing: EditButton()
            )
            .sheet(isPresented: $isThemeEditorShowing){
                ThemeEditorView(theme: themesStore.bindingToTheme(newTheme!),
                                isPresented: $isThemeEditorShowing)
            }
            .environment(\.editMode, $isListEditMode)
        }
    }
    
}


struct ThemeChoserRow: View {
    var theme: Theme
    var isEdit: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
            Text(theme.name)
            ThemeFillAndSamplesView(theme: theme, isEdit: isEdit)
        }
        .padding(.bottom, 6)
    }
}

struct ThemeFillAndSamplesView: View {
    var theme: Theme
    var isEdit: Bool
    
    var body: some View {
        
        let cards = EmojiiMemoryGameVM.themeCardsSample(theme: theme)
        var coverCard = cards.last!
        coverCard.isFaceUp = false
        let fill = EmojiiMemoryGameVM.themeFill(theme: theme)
        
        return HStack(spacing: 4) {
            
            // Edit button
            if isEdit {
                ZStack {
                    CardView(card: coverCard, fill: [Color.accentColor])
                    VStack(spacing: 3){
                        Text("\(Image(systemName: "slider.horizontal.3"))").font(.title3)//.fontWeight(.bold)
                        Text("EDIT").font(.caption2).fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                }
                .frame(width: Self.sampleSize * 1, height: Self.sampleSize)
            }

            
            // Cover sample with pairs number.
            ZStack {
                CardView(card: coverCard, fill: fill)
                VStack(spacing: 0){
                    Text("\(theme.pairsToShow)").font(.title3).fontWeight(.bold)
                    Text("pairs of").font(.caption2).fontWeight(.bold)
                }
                .foregroundColor(.white)
            }
            .frame(width: Self.sampleSize * 1, height: Self.sampleSize)
            
            // Card samples
            ForEach(cards) { card in
                CardView(card: card, fill: fill)
                    .frame(width: Self.sampleSize, height: Self.sampleSize)
                    .foregroundColor(EmojiiMemoryGameVM.themeForegroundColor(theme: theme))
            }
        }
    }
    
    static private let sampleSize: CGFloat = 58
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
        
    }
}
