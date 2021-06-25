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
    
    
    private enum EmojisEditMode: String {
        case inactive
        case newEmojis
        case hideEmojis
        case deleteEmojis
    }
    
    @State private var emojisEditMode: EmojisEditMode = .inactive
    @State private var emojisToAdd: String = ""
    
    var body: some View {
        VStack {
            
            header(title: "Edit Theme")
            
            Form{
                
                Section(header: Text("Theme name")){
                    TextField("\(theme.name)", text: $theme.name)
                }
                
                
                Section(header: Text("Emojis")){
                    
                    
                    Group {
                        
                        // Action bar for editing emoji collection.
                        if emojisEditMode == .inactive {
                            HStack {
                                wideButton("New") { emojisEditMode = .newEmojis }
                                Divider()
                                wideButton("Hide") { emojisEditMode = .hideEmojis  }
                                Divider()
                                wideButton("Delete") { emojisEditMode = .deleteEmojis }
                            }
                            
                        }
                        
                        
                        
                        // Add emoji's controls.
                        if emojisEditMode == .newEmojis {
                            HStack{
                                TextField("Type new emoji here", text: $emojisToAdd)
                                Button("Add") {
                                    emojisToAdd.forEach { theme.emojis.insert(String($0), at: 0) }
                                    // TODO: Don't add invisible (space, tab, etc.) emoji.
                                    // TODO: Don't add emoji twice.
                                    emojisToAdd = ""
                                    emojisEditMode = .inactive
                                }
                            }
                        }
                        
                        // Hide emoji's controls.
                        if emojisEditMode == .hideEmojis {
                            HStack{
                                Text("Hide Emojis")
                                Spacer()
                                Button("Done") {
                                    emojisEditMode = .inactive
                                }
                            }
                        }
                        
                        // Delete emoji's controls.
                        if emojisEditMode == .deleteEmojis {
                            HStack{
                                Text("Delete Emojis")
                                Spacer()
                                Button("Done") {
                                    emojisEditMode = .inactive
                                }
                            }
                        }
                        
                        
                    }
                    
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
    
    func wideButton(_ label: String, action: @escaping ()-> Void) -> some View {
        Button(
            action: action,
            label: {
                HStack{
                    Spacer()
                    Text(label).fixedSize()
                    Spacer()
                }
            })
            .buttonStyle(BorderlessButtonStyle())
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
