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
        
        Grid (viewModel.cards¨) { card in
            CardView(card: card)
                .onTapGesture{
                    viewModel.choose(card: card)
                }
                .padding(7)
        }
        .padding()
        .foregroundColor(viewModel.themeColor)
    }
}


struct CardView: View {
    var card: MemoryGameModel<String>.Card
    
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
                }
            }
        }
//        .aspectRatio(2/3, contentMode: .fit)
        // TODO: fix aspectRatio for cards
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

