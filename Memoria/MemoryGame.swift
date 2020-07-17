//
//  MemoryGame.swift
//  Memoria
//
//  Created by De La Cruz, Eduardo on 17/07/2020.
//  Copyright © 2020 De La Cruz, Eduardo. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(card: Card) {
        print("Card selected: \(card)")
    }
    
    struct Card: Identifiable {
        var id: String = UUID().uuidString
        var isFaceUp: Bool = true
        var isMathced: Bool = false
        var content: CardContent
    }
}
