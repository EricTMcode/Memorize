//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eric on 14/09/2024.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["👻","🎃", "😈", "💀", "🤩", "🥶", "☀️", "👋", "🐙"].shuffled()

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }

    private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
