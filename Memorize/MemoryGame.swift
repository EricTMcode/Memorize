//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Eric on 14/09/2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }

    func choose(_ card: Card) {

    }

    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent

        var id: String

        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
}
