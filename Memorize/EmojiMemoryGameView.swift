//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Fedor Boretsky on 30.09.2020.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiiMemoryGameVM
    @Binding var backButtonColor: Color
    
    var body: some View {
        
        VStack {
            
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
                    Text("""
                        Matched cards: \(viewModel.scoreMatchedReward, specifier: "%g"). \
                        Mismatched cards: \(viewModel.scoreMismatchedPenalty, specifier: "%g"). \
                        Speed\(Symbols.nonBreakingSpace)amplification: \(viewModel.scoreSpeedAmplification, specifier: "%+.1f")
                        """)
                        .font(.callout)
                }
                Spacer()
            }
            .foregroundColor(.gray)
            .padding([.horizontal, .bottom])
            .navigationBarTitle(viewModel.themeName)
            .navigationBarItems(trailing: newGameButton)
        }
        .padding()
        .foregroundColor(viewModel.themeForegroundColor)
        .onAppear{ backButtonColor = viewModel.themeForegroundColor }
    }
    
    var newGameButton: some View {
        Button("New Game") {
            withAnimation(.easeInOut){
                viewModel.newGame()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiiMemoryGameVM(theme: ThemesStore.themesStarterPack[0])
            game.choose(card: game.cards[0])
            return
                NavigationView {
                    EmojiMemoryGameView(viewModel: game, backButtonColor: .constant(.green))
                }
    }
}

