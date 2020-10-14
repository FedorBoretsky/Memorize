//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import Foundation

struct MemoryGameModel<CardContentType> {
    
    var cardsBunch: Array<Card>
    
    mutating func choose(card: Card){
        print("Card choosen: \(card)")
        let choosenIndex = index(of: card)
        cardsBunch[choosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cardsBunch.count {
            if card.id == cardsBunch[index].id {
                return index
            }
        }
        return 0  // TODO: bogus!
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType){
        cardsBunch = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cardsBunch.append(Card(content: content, id: pairIndex * 2))
            cardsBunch.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cardsBunch.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContentType
        var id: Int
    }
}
