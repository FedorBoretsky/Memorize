//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Fedor Boretsky on 30.09.2020.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiiMemoryGameVM
    var body: some View {
        
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.themeName)
                    .font(.title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button("New Game") {
                    viewModel.newGame()
                }
            }.padding([.horizontal, .top])
            
            HStack(alignment: .firstTextBaseline) {
                Text(" Score: \(viewModel.score, specifier: "%.1f") (with speeding points: \(viewModel.bonus, specifier: "%-.1f"))")
                    .foregroundColor(.primary)
                
                Spacer()
            }.padding()
            
            Grid (viewModel.cards¨, desiredAspectRatio: 1) { card in
                CardView(card: card, fill: viewModel.themeFill)
                    .onTapGesture{
                        viewModel.choose(card: card)
                    }
                    .padding(7)
            }
            
            
        }
        .padding()
        .foregroundColor(viewModel.themeColor)
    }
}


struct CardView: View {
    var card: MemoryGameModel<String>.Card
    var fill: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            self.body(size: geometry.size)
        }
    }
    
    func body (size: CGSize) -> some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius(for: size)).stroke(lineWidth: borderWidth)
                RoundedRectangle(cornerRadius: cornerRadius(for: size)).fill(Color.white)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius(for: size))
                        .fill(LinearGradient(gradient: Gradient(colors: fill), startPoint: .bottomLeading, endPoint: .topTrailing))
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // - MARK: Control panel
    
    func cornerRadius(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.125
    }
    
    let borderWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiMemoryGameView(viewModel: EmojiiMemoryGameVM())
        }
        
    }
}

