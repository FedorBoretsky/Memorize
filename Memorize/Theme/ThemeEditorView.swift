//
//  ThemeEditorView.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 23.06.2021.
//

import SwiftUI

struct ThemeEditorView: View {
    
    @Binding var theme: Theme
    @State private var emojisToAdd: String = ""
    
    @State private var selectedEmoji: String? = "👻"
    
    var body: some View {
        VStack {
            Text("Edit theme \(theme.name)").font(.headline)
                .padding()
            Divider()
            
            Form{
                
                Section(header: Text("Theme name")){
                    TextField("\(theme.name)", text: $theme.name)
                }
                
                
                Section(header: Text("Emojis")){
                    
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: {isBegin in
                        if !isBegin {
                            emojisToAdd.forEach { theme.emojis.insert(String($0), at: 0) }
                            // TODO: Don't add emoji twice.
                            emojisToAdd = ""
                        }
                    }
                    )
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 90, maximum: 150))]) {
                        ForEach(theme.emojis, id: \.self) { emoji in
                            EmojiItemView(emoji: emoji, selectedEmoji: $selectedEmoji)
                            
                        }
                    }
                }
            } // End of Form
            
            Spacer()
        } // End of Vstack
        .frame(minWidth: 300, minHeight: 500)
    }
}

struct ThemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditorView(theme: .constant(Theme.exampleHalloween))
    }
}

struct EmojiItemView: View {
    
    let emoji: String
    @Binding var selectedEmoji: String?
    
    var isSelected: Bool {
        if let se = selectedEmoji, se == emoji {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack {
            Text(emoji)
                .font(.system(size: 40))
                .padding()
            if isSelected {
                VStack {
                    Spacer()
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "trash")
                        })
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "eye.slash")
                        })
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
