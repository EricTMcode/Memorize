//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eric on 13/09/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50

    var body: some View {
        VStack {
            cards.foregroundStyle(viewModel.color)
            HStack {
                score
                Spacer()
                deck.foregroundStyle(viewModel.color)
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
    }

    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }

    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }

    @State private var dealt = Set<Card.ID>()

    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }

    @Namespace private var dealingNameSpace

    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }

    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }

    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }

    @State private var lastScoreChange = (0, causedByCardId: "")

    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.title)
//    }
//
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button() {
//           cardCount += offset
//        } label: {
//            Image(systemName: symbol)
//        }
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "minus.circle")
//    }
//
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "plus.circle")
//    }
