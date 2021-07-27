//
//  FillView.swift
//  Memorize
//
//  Created by Fedor Boretskiy on 27.07.2021.
//

import SwiftUI

struct FillView: View {
    let fill: Fill
    let isSelected: Bool
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            // Fill.
            Rectangle()
                .cardify(isFaceUp: false, coverFill: fill.map{Color($0)})
            
            // Selection Indicator.
            if isSelected {
                Image(systemName: "checkmark.circle")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .transition(.scale)
                    .font(.system(size: 24))
                    .padding(5)
            }
        }
    }
}

struct FillView_Previews: PreviewProvider {
    static var previews: some View {
        FillView(fill: [UIColor(#colorLiteral(red: 0.998834908, green: 0.2302215695, blue: 0.1895241439, alpha: 1)).rgb, UIColor(Color.orange).rgb, UIColor(#colorLiteral(red: 1, green: 0.7764705882, blue: 0, alpha: 1)).rgb], isSelected: true)
            .frame(width: 65, height: 65)
    }
}
