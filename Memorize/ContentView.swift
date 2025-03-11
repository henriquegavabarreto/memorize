//
//  ContentView.swift
//  Memorize
//
//  Created by Henrique Barreto on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🦁", "🐭", "🐯", "🐮"]
    let cardBaseColor: Color = .orange
    
    var body: some View {
        HStack {
            ForEach(emojis, id: \.self) { emoji in
                CardView(faceValue: emoji)
            }
        }
        .foregroundColor(cardBaseColor)
        .padding()
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
            if isFaceUp {
                baseShape
                    .foregroundColor(.white)
                baseShape
                    .strokeBorder(lineWidth: 3)
                Text(faceValue)
                    .font(.largeTitle)
            } else {
                // Show back of the card only
                baseShape
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
