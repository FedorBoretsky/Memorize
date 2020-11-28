//
//  Cardify.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 28.11.2020.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var coverFill: [Color]
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in 
            ZStack{
                if isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke(lineWidth: borderWidth)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(Color.white)
                    content
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                        .fill(LinearGradient(gradient: Gradient(colors: coverFill), startPoint: .bottomLeading, endPoint: .topTrailing))
                }
            }
        }
        
    }
    
    private let borderWidth: CGFloat = 3
    private func cornerRadius(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.125
    }
    
}

extension View {
    func cardify(isFaceUp: Bool, coverFill: [Color]) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, coverFill: coverFill))
    }
}
