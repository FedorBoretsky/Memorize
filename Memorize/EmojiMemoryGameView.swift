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
                    withAnimation(.easeInOut){
                        viewModel.newGame()
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 0.15)
            
            Grid (viewModel.cards, desiredAspectRatio: 1) { card in
                CardView(card: card, fill: viewModel.themeFill)
                    .onTapGesture{
                        withAnimation(.linear(duration: 0.5)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(7)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Score: \(viewModel.scoreTotal, specifier: "%.1f")")
                        .font(.headline)
//                        .foregroundColor(.primary)
                    Text("""
                        Matched cards: \(viewModel.scoreMatchedReward, specifier: "%g"). \
                        Mismatched cards: \(viewModel.scoreMismatchedPenalty, specifier: "%g"). \
                        Speed\(Symbols.nonBreakingSpace)amplification: \(viewModel.scoreSpeedAmplification, specifier: "%+.1f")
                        """)
                }
                Spacer()
            }
            .font(.callout)
            .foregroundColor(.gray)
            .padding([.horizontal, .bottom])
            
            
            
        }
        .padding()
        .foregroundColor(viewModel.themeForegroundColor)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiiMemoryGameVM(theme: ThemesStore.themesStarterPack[0])
            game.choose(card: game.cards[0])
            return EmojiMemoryGameView(viewModel: game)
    }
}

