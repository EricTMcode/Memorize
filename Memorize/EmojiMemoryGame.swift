//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eric on 14/09/2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻","🎃", "😈", "💀", "🤩", "🥶", "☀️", "👋", "🐙"].shuffled()

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }

    @Published private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
