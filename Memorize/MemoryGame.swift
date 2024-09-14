//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Eric on 14/09/2024.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>

    func choose(_ card: Card) {

    }

    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
