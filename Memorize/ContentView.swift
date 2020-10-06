//
//  ContentView.swift
//  Memorize
//
//  Created by Fedor Boretsky on 30.09.2020.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiiMemoryGameViewModel
    var body: some View {
        
        HStack {
            ForEach(viewModel.cardsBunch) { card in
                CardView(card: card)
                    .onTapGesture{
                        viewModel.choose(card: card)
                    }
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(Font.largeTitle)
        
    }
}


struct CardView: View {
    var card: MemoryGameModel<String>.Card
    
    var body: some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiiMemoryGameViewModel())
            
    }
}

