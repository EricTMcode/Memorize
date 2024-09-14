//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Eric on 13/09/2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
