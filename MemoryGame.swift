//
//  MemoryGame.swift
//  Memorize
//
//  Created by Muskaan Agrawal on 9/28/20.
//  Copyright © 2020 Muskaan Agrawal. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if !cards[chosenIndex].isMatched, !cards[potentialMatchIndex].isMatched, !cards[chosenIndex].isSeen, !cards[potentialMatchIndex].isSeen {
                score += 0
                } else if !cards[chosenIndex].isMatched, !cards[potentialMatchIndex].isMatched, cards[chosenIndex].isSeen, !cards[potentialMatchIndex].isSeen {
                score -= 1
                } else if !cards[chosenIndex].isMatched, !cards[potentialMatchIndex].isMatched, cards[chosenIndex].isSeen, cards[potentialMatchIndex].isSeen {
                score -= 2
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].isSeen = true
                cards[potentialMatchIndex].isSeen = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }   
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
        
    }
}
