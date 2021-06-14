//
//  CardView.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 14.06.2021.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGameModel<String>.Card
    var fill: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            self.body(size: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body (size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90))
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90))
                    }
                }
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


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: <#MemoryGameModel<String>.Card#>, fill: <#[Color]#>)
//    }
//}
