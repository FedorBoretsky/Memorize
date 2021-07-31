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
                            EmojiItemView(emoji: emoji, editMode: emojisEditMode, theme: $theme)
                                .onTapGesture { self.performEditActionOnEmoji(emoji) }
                        }
                    }
                    
                }
                
                Section(header: Text("Show in game")){
                    Stepper("\(theme.pairsToShow) pairs", value: $theme.pairsToShow, in: 2...theme.emojis.count)
                }
                
                Section(header: Text("Cover color")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 150))]){
                        ForEach(Array(FillStore.shared.items), id: \.self) { fill in
                            FillView(fill: fill, isSelected: fill == theme.fill)
                                .frame(width: 65, height: 65)
                                .onTapGesture {
                                    theme.fill = fill
                                }
                        }
                    }
                }
                
                
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
            wideButton("Add") { withAnimation{  emojisEditMode = .addEmojis } }
            Divider()
            wideButton("Usage") { emojisEditMode = .hideEmojis  }
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
                withAnimation {
                    theme.addEmojis(string: emojisToAdd)
                    emojisToAdd = ""
                    emojisEditMode = .selectAction
                }
            }
        }
    }
    
    fileprivate func hideEmojisControls() -> some View {
        return HStack{
            Text("Tap emoji to toggle usage.")
            Spacer()
            Button("Finish") {
                emojisEditMode = .selectAction
            }
        }
    }
    
    
    fileprivate func deleteEmojisControls() -> some View {
        return HStack{
            if !theme.isMinimumEmojiCount {
                Text("Tap emoji to delete.")
            }else{
                Text("Theme must have at least \(theme.minimumEmojiCount) emojis.").foregroundColor(.red)
            }
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
            // TODO: isMininmumEmojiCount replace to isMinimumVisibleEmojiCount
            if !theme.isMinimumEmojiCount {
                withAnimation{ theme.toogleVisibilityEmoji(emoji) }
            }
        case .deleteEmojis:
            // TODO: isMininmumEmojiCount replace to isMinimumVisibleEmojiCount
            if !theme.isMinimumEmojiCount {
                withAnimation{ theme.removeEmoji(emoji) }
            }
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
    @Binding var theme: Theme
    
    var isHidden: Bool { theme.hiddenEmojis.contains(emoji) }
    let emojiSize: CGFloat = 40
    let badgeSize: CGFloat = 18
    let badgePadding: CGFloat = 5

    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            ZStack{
                
                // Emoji
                Text(emoji)
                    .opacity( isHidden ? 0.3 : 1)
                    .font(.system(size: emojiSize))
                    .padding(.vertical)
                    .frame(width: 60, height: 60, alignment: .center)
                
                // Hidden emoji sign
                if isHidden {
                    Image(systemName: "eye.slash")
                        .font(.system(size: emojiSize * 0.55))
                        .foregroundColor(Color.init(white: 0.5))
                }
            }
            
            
            // Delete command badge
            if editMode == .deleteEmojis {
                Image(systemName: "minus.circle.fill")
                    .renderingMode(theme.isMinimumEmojiCount ? .template : .original)
                    .foregroundColor(.gray)
                    .transition(.scale)
                    .font(.system(size: badgeSize))
                    .padding(badgePadding)
            }
            
            // Hide command badge
            if editMode == .hideEmojis {
                ZStack {
                    Image(systemName: "circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(.white)
//                        .transition(.scale)
                
                    Image(systemName: isHidden ? "circle" : "checkmark.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(.accentColor)
//                        .transition(.scale)
                }
                .font(.system(size: badgeSize))
                .padding(badgePadding)

            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
