//
//  EmojiMemoryGame.swift
//  Memoria
//
//  Created by De La Cruz, Eduardo on 17/07/2020.
//  Copyright © 2020 De La Cruz, Eduardo. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    //    private(set) var model: MemoryGame<String> (Crystal door example)
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    // MARK: - Static Functions
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in emojis[pairIndex] }
    }
}
