//
//  ContentView.swift
//  Memorize
//
//  Created by Henrique Barreto on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: Themes
    // Dictionary with all available themes
    let themes = [
        "animals" : ["🦁", "🐭", "🐯", "🐮", "🐸", "🦊", "🐻", "🐰"],
        "fruits": ["🍏", "🍎", "🍒", "🍓", "🍇", "🍌", "🍍", "🍉"],
        "flags": ["🇧🇷", "🇮🇹", "🇫🇷", "🇭🇷", "🇨🇱", "🇮🇪", "🇨🇳", "🇹🇼"]
    ]
    
    // dictionary with available colors
    let colors: [String: Color] = [
        "animals": .blue,
        "fruits": .red,
        "flags": .green
    ]
    
    // current chosen theme
    @State var currentTheme: [String] = []
    
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
            Spacer()
            themeChangers
        }
    }
    
    // MARK: Cards
    // creates cards on the screen
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            // loop through current chosen theme and create cards for each array value
            ForEach(0..<currentTheme.count, id: \.self) { index in
                CardView(faceValue: currentTheme[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardBaseColor)
        .padding()
    }
    
    // #MARK: Theme change
    // Changes chosen theme
    func changeTheme(_ name: String) {
        // assigns value to chosen theme if it exists
        if let chosenTheme = themes[name] {
            currentTheme = chosenTheme
            // Extra credit: Make a random number of pairs of cards appear each time a theme button is chosen
            // currentTheme = Array(currentTheme[0..<Int.random(in: 4..<currentTheme.count)])
            // duplicate the array to form pairs
            currentTheme += currentTheme
            // shuffle the duplicated array
            currentTheme = currentTheme.shuffled()
            // Extra credit: changes color according to chosen theme - defaults to orange
            cardBaseColor = colors[name] ?? .orange
        }
    }
    
    // Buttons that allow change of the current theme
    var themeChangers: some View {
        HStack(alignment: .lastTextBaseline) {
            themeChangerButton(themeName: "animals", title: "Animals", symbol: "dog")
            themeChangerButton(themeName: "fruits", title: "Fruits", symbol: "apple.logo")
            themeChangerButton(themeName: "flags", title: "Flags", symbol: "flag")
        }
    }
    
    // Returns a button that changes the current theme
    func themeChangerButton(themeName: String, title: String, symbol: String) -> some View {
        Button(action: { changeTheme(themeName) }) {
            VStack {
                Image(systemName: symbol)
                Text(title)
            }
            .font(.body)
            .padding(.horizontal)
            .imageScale(.large)
        }
    }
}

// #MARK: Card View
struct CardView: View {
    let faceValue: String
    @State var isFaceUp = false
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
