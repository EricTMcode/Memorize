//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eric on 14/09/2024.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String>

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
