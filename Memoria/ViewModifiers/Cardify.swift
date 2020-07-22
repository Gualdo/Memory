//
//  Cardify.swift
//  Memoria
//
//  Created by De La Cruz, Eduardo on 20/07/2020.
//  Copyright © 2020 De La Cruz, Eduardo. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool {
        rotation < ninetyDegrees
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? zeroDregrees : halfCircle
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidht)
                
                content
            }
            .opacity(isFaceUp ? opaque : transparent)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .opacity(isFaceUp ? transparent : opaque)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: yAxis)
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidht: CGFloat = 3
    private let zeroDregrees: Double = 0
    private let halfCircle: Double = 180
    private let ninetyDegrees: Double = 90
    private let opaque: Double = 1
    private let transparent: Double = 0
    private let yAxis: (CGFloat, CGFloat, CGFloat) = (0,1,0)
}

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
