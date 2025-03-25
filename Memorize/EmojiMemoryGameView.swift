//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Henrique Barreto on 3/6/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // Observes existing object - Dependency Injection from Parent View
    @ObservedObject var viewModel: EmojiMemoryGame

    // color applied to the back of the card - defaults to orange
    @State var cardBaseColor: Color = .orange
    
    // MARK: Main
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding()
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
    }
    
    // MARK: Cards
    // creates cards on the screen
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            // loop through current chosen theme and create cards for each array value
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(cardBaseColor)
        .padding()
    }
}

// #MARK: Card View
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            // Define card base shape
            let baseShape = RoundedRectangle(cornerRadius: 15.0)
            // Show card face up
            Group {
                baseShape
                    .foregroundColor(.white)
                baseShape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            // Show back of the card only
            baseShape
                .opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
