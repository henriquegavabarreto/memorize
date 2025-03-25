//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Henrique Barreto on 3/6/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // Owner of game - insures persistence and single source of truth being on a parent View
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
