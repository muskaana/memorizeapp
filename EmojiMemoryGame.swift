//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Muskaan Agrawal on 9/28/20.
//  Copyright © 2020 Muskaan Agrawal. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    private static var gameTheme: Theme =  EmojiMemoryGame.gameThemes()[Int.random(in: 0...2)]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: gameTheme.number) { pairIndex in
            return gameTheme.values[pairIndex]
        }
       
    }	
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    //MARK: - Access to ViewModel
    
    func getColor() -> Color {
        return EmojiMemoryGame.gameTheme.color
    }
    
    func getThemeName() -> String {
        return EmojiMemoryGame.gameTheme.name
    }
    
    func updateMemoryGame() {
        EmojiMemoryGame.gameTheme =  EmojiMemoryGame.gameThemes()[Int.random(in: 0...2)]
        model = EmojiMemoryGame.createMemoryGame()
    }   
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    
    static func gameThemes() -> Array<Theme> {
        var themes = Array<Theme>()
        themes.append(Theme(values: ["👻","🎃", "🕷", "🍬", "🕸"], name: "Halloween", number: 3, color: .orange))
        themes.append(Theme(values: ["🍁", "🍄", "☕️", "🍂", "🍃"], name: "Fall", number: 4, color: .green))
        themes.append(Theme(values: ["🥶", "⛄️", "❄️", "🌨", "⛷"], name: "Winter", number: Int.random(in: 2...4), color: .blue))
        return themes
    }
   
    struct Theme {
        var values: [String]
        var name: String
        var number: Int
        var color: Color
    }


}

