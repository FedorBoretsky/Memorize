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
            }.padding([.horizontal, .top])
            
            HStack(alignment: .firstTextBaseline) {
                Text(" Score: \(viewModel.score, specifier: "%.1f") (bonus points: \(viewModel.bonus, specifier: "%-.1f"))")
                    .foregroundColor(.primary)
                
                Spacer()
            }.padding()
            
            Grid (viewModel.cards¨, desiredAspectRatio: 1) { card in
                CardView(card: card, fill: viewModel.themeFill)
                    .onTapGesture{
                        withAnimation(.linear(duration: 0.5)) {
                            viewModel.choose(card: card)
                        }
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
    
    @ViewBuilder
    private func body (size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(15))
                    .padding(5)
                    .opacity(0.33)
                Text(card.content)
                    .font(Font.system(size: emojiFontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, coverFill: fill)
            .transition(.scale)
        }
    }
    
    // - MARK: Drawing parameters    
    
    private func emojiFontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.65
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            let game = EmojiiMemoryGameVM()
            game.choose(card: game.cards¨[0])
            return EmojiMemoryGameView(viewModel: game)
    }
}

