//
//  EmojiMemoryGameView.swift
//  Memoria
//
//  Created by De La Cruz, Eduardo on 15/07/2020.
//  Copyright © 2020 De La Cruz, Eduardo. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: self.flipAnimationDuration)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(self.customPadding)
            }
            .padding()
            .foregroundColor(.orange)
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
    }
    
    // MARK: - Drawing Constants
    
    private let customPadding: CGFloat = 5
    private let flipAnimationDuration: Double = 0.75
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    @ViewBuilder private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(startAngle), endAngle: Angle.degrees(-animatedBonusRemaining * fullCircle - ninetyDegrees), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(startAngle), endAngle: Angle.degrees(-card.bonusRemaining * fullCircle - ninetyDegrees), clockwise: true)
                    }
                }
                .padding(customPadding)
                .opacity(pieOpacity)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? fullCircle : zeroDregrees))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * fontScaleFactor
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // MARK: - Drawing Constants

    private let fontScaleFactor: CGFloat = 0.7
    private let fullCircle: Double = 360
    private let zeroDregrees: Double = 0
    private let halfCircle: Double = 180
    private let customPadding: CGFloat = 5
    private let pieOpacity: Double = 0.4
    private let startAngle: Double = 0 - 90
    private let endAngle: Double = 110 - 90
    private let ninetyDegrees: Double = 90
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
