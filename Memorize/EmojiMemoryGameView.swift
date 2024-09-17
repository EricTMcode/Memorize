//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eric on 13/09/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    var cards: some View {
        GeometryReader { geo in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geo.size,
                atAspectRation: 2/3
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundStyle(.orange)
    }

    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRation aspectRation: CGFloat
    ) -> CGFloat {
        var columnCount = 1
        repeat {

        } while columnCount < count



        return 65
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
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
