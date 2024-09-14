//
//  ContentView.swift
//  Memorize
//
//  Created by Eric on 13/09/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃", "😈", "💀", "🤩", "🥶", "☀️", "👋", "🐙"].shuffled()

    var body: some View {
        NavigationStack {
                ScrollView {
                    cards
                }
            .padding()
            .navigationTitle("Memorize!")
        }
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
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

struct CardView: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
