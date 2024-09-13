//
//  ContentView.swift
//  Memorize
//
//  Created by Eric on 13/09/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃", "😈", "💀", "🤩", "🥶", "☀️", "👋", "🐙"]

    @State private var cardCount = 4

    var body: some View {
        VStack {
            cards
            cardCountAdjusters
        }
        .padding()
    }

    var cards: some View {
        HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundStyle(.orange)
    }

    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.title)
    }

    var cardRemover: some View {
        Button() {
            if cardCount > 1 {
                cardCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }

    var cardAdder: some View {
        Button() {
            if cardCount < emojis.count {
                cardCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            } else {
                base.fill()
            }
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
