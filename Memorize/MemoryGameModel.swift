//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import Foundation

struct MemoryGameModel<CardContentType> where CardContentType: Equatable {
    
    var cards¨: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards¨.indices.filter { cards¨[$0].isFaceUp }.only }
        set {
            for index in cards¨.indices {
                cards¨[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func choose(card: Card){
        if let choosenIndex = cards¨.firstIndex(matching: card), !cards¨[choosenIndex].isFaceUp, !cards¨[choosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards¨[choosenIndex].content == cards¨[potentialMatchIndex].content {
                    cards¨[choosenIndex].isMatched = true
                    cards¨[potentialMatchIndex].isMatched = true
                }
                cards¨[choosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType){
        cards¨ = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards¨.append(Card(content: content, id: pairIndex * 2))
            cards¨.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards¨.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isAlreadySeen: Bool = false
        var mismatchPenalty: Int = 0
        var content: CardContentType
        var id: Int
    }
}
