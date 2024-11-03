//
//  SquareCard.swift
//  Manage
//
//  Created by Vasim Khan on 10/23/24.
//

import SwiftUI

struct SquareCard: View {
    var bgColor: Color
    var title: String
    var icon: String
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    
    var body: some View {
        ZStack {
            
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    
                    Text(title)
                        .lineLimit(2)
                        .font(.appFont(.medium, size: 18))
                        .foregroundColor(AppColor.appBlackFont)
                    
                    Rectangle()
                        .foregroundColor(Color.clear)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 1, maxHeight: 1)
                    
                    
                }
                .frame(width: ((UIScreen.main.bounds.width - 55) / 2) - 55, height: ((UIScreen.main.bounds.width - 55) / 2) - 45)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Spacer()
                        
                        Image(String(icon))
                            .foregroundColor(AppColor.appBlackFont)
                    }
                    Spacer()
                }
                .frame(width: ((UIScreen.main.bounds.width - 55) / 2) - 65, height: ((UIScreen.main.bounds.width - 55) / 2) - 65)
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(bgColor)
        .cornerRadius(15)
    }
}

#Preview {
    SquareCard(bgColor: Color.appLightGreenColor, title: "Lead \nGeneration", icon: "ic_lead_generation", cardWidth: 150, cardHeight: 150)
}
