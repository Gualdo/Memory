//
//  MemoryGame.swift
//  Memoria
//
//  Created by De La Cruz, Eduardo on 17/07/2020.
//  Copyright © 2020 De La Cruz, Eduardo. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    
    struct Card: Identifiable {
        var id: String = UUID().uuidString
        var isFaceUp: Bool = true
        var isMathced: Bool = false
        var content: CardContent
    }
    
    var cards: [Card]
    
    // MARK: - Init(s)
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    // MARK: - Custom functions
    
    mutating func choose(card: Card) {
        print("Card selected: \(card)")
        guard let chosenIndex = index(of: card) else { return }
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
}
