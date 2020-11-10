//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import Foundation

struct MemoryGameModel<CardContentType> {
    
    var cardš: Array<Card>
    
    mutating func choose(card: Card){
        print("Card choosen: \(card)")
        if let choosenIndex = cardš.firstIndex(matching: card) {
            cardš[choosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType){
        cardš = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cardš.append(Card(content: content, id: pairIndex * 2))
            cardš.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cardš.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContentType
        var id: Int
    }
}
