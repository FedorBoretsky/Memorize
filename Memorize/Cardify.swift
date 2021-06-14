//
//  Cardify.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 28.11.2020.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
        
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    var coverFill: [Color]

    init(isFaceUp: Bool, coverFill: [Color]) {
        self.rotation = isFaceUp ? 0 : 180
        self.coverFill = coverFill
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in 
            ZStack{
                Group {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                        .strokeBorder(lineWidth: borderWidth(for: geometry.size))
                    content
                }
                .opacity(isFaceUp ? 1 : 0)
                RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                    .fill(LinearGradient(gradient: Gradient(colors: coverFill),
                                         startPoint: .bottomLeading,
                                         endPoint: .topTrailing))
                    .opacity(isFaceUp ? 0 : 1)
            }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        }
    }
    
    private func borderWidth(for size: CGSize) -> CGFloat {
        if min(size.width, size.height) <= 77 {
            return 2
        } else {
            return 3
        }
    }
    private func cornerRadius(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.125
    }
    
}

extension View {
    func cardify(isFaceUp: Bool, coverFill: [Color]) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, coverFill: coverFill))
    }
}
