//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Fedor Boretsky on 05.10.2020.
//

import Foundation

struct MemoryGameModel<CardContentType>: Codable
where CardContentType: Equatable, CardContentType: Codable {
    
    private(set) var cards: Array<Card>
    
    
    // MARK: - Score
    
    var scoreTotal : Double {
        scoreMatchedReward + scoreMismatchedPenalty + scoreSpeedAmplification
    }
    
    
    private(set) var scoreMatchedReward : Double = 0
    private(set) var scoreMismatchedPenalty : Double = 0
    private(set) var scoreSpeedAmplification : Double = 0

    private var lastCardChosenDate: Date? = nil
    private func lastMoveSpeedAmplification(points: Double) -> Double {
        if let lastDate = lastCardChosenDate {
            let speedMaxReward: Double = 3
            let timeSincePreviousTouch = -lastDate.timeIntervalSinceNow
            let factor = max(1, speedMaxReward - timeSincePreviousTouch)
            let extendedPoints = points * factor
            return extendedPoints - points
        } else {
            return 0
        }
    }
    
    private mutating func matchingReward(_ points: Double) {
        scoreMatchedReward += points
        scoreSpeedAmplification += lastMoveSpeedAmplification(points: points)
    }

    private mutating func mismatchingPenalize(_ points: Double) {
        scoreMismatchedPenalty += points
        scoreSpeedAmplification += lastMoveSpeedAmplification(points: points)
    }

    // MARK: -
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isAlreadySeen = cards[index].isAlreadySeen || cards[index].isFaceUp
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func choose(card: Card){
        
        if let choosenIndex = cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
                        
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // 1 card opened now, 2 cards will be opened
                if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                    // Matched
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    matchingReward(2)
                } else {
                    // Not matched
                    if cards[choosenIndex].isAlreadySeen {
                        mismatchingPenalize(-1)
                    }
                    if cards[potentialMatchIndex].isAlreadySeen {
                        mismatchingPenalize(-1)
                    }
                }
                cards[choosenIndex].isFaceUp = true
            } else {
                // 2 cards open now, they will be closed and opened another card
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
            
            lastCardChosenDate = Date()

        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    
    struct Card: Identifiable, Codable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var isAlreadySeen: Bool = false
        var mismatchPenalty: Int = 0
        var content: CardContentType
        var id: Int
        
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before certain amount of time passes
        // during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isFaceUp && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transition to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
    
    
}
