//
//  MemoryGame.swift
//  Memorize
//
//  Created by Henrique Barreto on 3/24/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // Add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    mutating func shuffle () {
        cards.shuffle()
    }
    
    var onlyFaceUpCardIndex: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(of: card) { // get index of chosen card
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched { // if card is not already face up or matched
                if let potentialMatchIndex = onlyFaceUpCardIndex { // if there is a single face up card
                    // if the face up card and the card just clicked have the same content
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    }
                } else { // there are 0 or 2 cards face up
                    onlyFaceUpCardIndex = chosenIndex
                }
                // turn the chosen card face up
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
