//
//  ThemeEditorView.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 23.06.2021.
//

import SwiftUI

struct ThemeEditorView: View {
    
    @Binding var theme: Theme
    @Binding var isPresented: Bool
    @State private var emojisToAdd: String = ""
    
    @State private var selectedEmoji: String? = "👻"
        
    var body: some View {
        VStack {
            
            header(title: "Edit Theme")
            
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
                    
                    // Grid of emojis
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 150))]) {
                        ForEach(theme.emojis, id: \.self) { emoji in
                            EmojiItemView(emoji: emoji)
                            
                        }
                    }
                } // End of section "Emojis"
            } // End of Form
        } // End of Vstack
        .frame(minWidth: 300, minHeight: 500)
    }
    
    func header(title: String) -> some View {
        ZStack {
            Text(title).font(.headline)
            HStack{
                Spacer()
                Button("Done") { isPresented = false }
            }
        }
        .padding()
    }

}

struct ThemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditorView(theme: .constant(Theme.exampleHalloween), isPresented: .constant(true))
    }
}

struct EmojiItemView: View {
    
    let emoji: String
    
    var body: some View {
        ZStack {
            Text(emoji)
                .font(.system(size: 40))
                .padding(.vertical)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
