//
//  ThemeEditorView.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 23.06.2021.
//

import SwiftUI


fileprivate enum EmojisEditMode {
    case selectAction
    case addEmojis
    case hideEmojis
    case deleteEmojis
}

struct ThemeEditorView: View {
    
    @Binding var theme: Theme
    @Binding var isPresented: Bool
    
    @State private var emojisEditMode: EmojisEditMode = .selectAction
    
    var body: some View {
        VStack {
            
            header(title: "Edit Theme")
            
            Form{
                
                Section(header: Text("Theme name")){
                    TextField("\(theme.name)", text: $theme.name)
                }
                
                Section(header: Text("Emojis")){
                    
                    // First line in the "Emojis" section select editing
                    // actions or provides controls for current action.
                    Group {
                        if emojisEditMode == .selectAction { emojiActionsSelector() }
                        if emojisEditMode == .addEmojis    { addEmojisControls()    }
                        if emojisEditMode == .hideEmojis   { hideEmojisControls()   }
                        if emojisEditMode == .deleteEmojis { deleteEmojisControls() }
                    }
                    
                    // Grid of emojis
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 150))]) {
                        ForEach(theme.emojis, id: \.self) { emoji in
                            EmojiItemView(emoji: emoji, editMode: emojisEditMode)
                                .onTapGesture { self.performEditActionOnEmoji(emoji) }
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
    
    private func emojiActionsSelector() -> some View {
        HStack {
            wideButton("Add") { emojisEditMode = .addEmojis }
            Divider()
            wideButton("Hide") { emojisEditMode = .hideEmojis  }
            Divider()
            wideButton("Delete") { withAnimation{ emojisEditMode = .deleteEmojis } }
        }
    }
    
    
    func wideButton(_ label: String, action: @escaping ()-> Void) -> some View {
        Button( action: action, label: {
            HStack{
                Spacer()
                Text(label).fixedSize()
                Spacer()
            }
        })
        .buttonStyle(BorderlessButtonStyle())
    }
    
    @State private var emojisToAdd: String = ""
    private func addEmojisControls() -> some View {
        HStack{
            TextField("Type new emoji here", text: $emojisToAdd)
            Button("Add") {
                emojisToAdd.forEach { theme.emojis.insert(String($0), at: 0) }
                // TODO: Don't add invisible (space, tab, etc.) emoji.
                // TODO: Don't add emoji twice.
                emojisToAdd = ""
                emojisEditMode = .selectAction
            }
        }
    }
    
    fileprivate func hideEmojisControls() -> some View {
        return HStack{
            Text("Hide Emojis")
            Spacer()
            Button("Finish") {
                emojisEditMode = .selectAction
            }
        }
    }
    
    fileprivate func deleteEmojisControls() -> some View {
        return HStack{
            Text("Tap emoji to delete.")
            Spacer()
            Button("Finish") { withAnimation{ emojisEditMode = .selectAction } }
        }
    }
    
    private func performEditActionOnEmoji(_ emoji: String) {
        
        switch emojisEditMode {
        case .selectAction:
            break
        case .addEmojis:
            break
        case .hideEmojis:
            break
        case .deleteEmojis:
            withAnimation{ theme.removeEmoji(emoji) }
        }
    }
    
}



struct ThemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditorView(theme: .constant(Theme.exampleHalloween), isPresented: .constant(true))
    }
}



struct EmojiItemView: View {
    
    let emoji: String
    fileprivate let editMode: EmojisEditMode
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // Emoji
            Text(emoji)
                .font(.system(size: 40))
                .padding(.vertical)
                .frame(width: 60, height: 60, alignment: .center)
            
            // Delete badge
            if editMode == .deleteEmojis {
                Image(systemName: "minus.circle.fill")
                    .renderingMode(.original)
                    .transition(.scale)
                    .font(.system(size: 25))
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
