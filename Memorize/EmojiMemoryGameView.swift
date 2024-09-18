//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eric on 13/09/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2/3

    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundStyle(.orange)
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



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
