//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Henrique Barreto on 3/24/25.
//

import SwiftUI

// Being an ObservableObject permits that the View will be able to see changes that occur
class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🍏", "🍎", "🍒", "🍓", "🍇", "🍌", "🍍", "🍉"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "☠️"
            }
        }
    }
    
    // published communicates changes of model when it occurs
    @Published var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
