//
//  ContentView.swift
//  Memorize
//
//  Created by Henrique Barreto on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🦁", "🐭", "🐯", "🐮", "🐸", "🦊", "🐻", "🐰"]
    let cardBaseColor: Color = .orange
    
    // number of cards showed on the screen
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
    }
    
    // cards on the screen
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                if(index < emojis.count) {
                    CardView(faceValue: emojis[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(cardBaseColor)
        .padding()
    }
    
    // Buttons at the bottom that adjust cardCount variable
    var cardCountAdjusters: some View {
        HStack {
            removeCardButton
            Spacer()
            addCardButton
        }
        .labelStyle(.iconOnly)
        .imageScale(.large)
        .font(.title)
        .padding()
    }
    
    func cardCountAdjuster (by offset: Int, title: String, symbol: String)  -> some View {
        Button(title, systemImage: symbol) {
            cardCount += offset
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    // Button - removes 1 from cardCount
    var removeCardButton: some View {
        cardCountAdjuster(by: -1, title: "Remove Card", symbol: "rectangle.stack.badge.minus.fill")
    }
    
    // Button - Adds 1 to cardCount
    var addCardButton: some View {
        cardCountAdjuster(by: 1, title: "Add Card", symbol: "rectangle.stack.badge.plus.fill")
    }
}


struct CardView: View {
    let faceValue: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            // Define card base shape
            let baseShape = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            // Show card face up
            Group {
                baseShape
                    .foregroundColor(.white)
                baseShape
                    .strokeBorder(lineWidth: 3)
                Text(faceValue)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            // Show back of the card only
            baseShape
                .opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
