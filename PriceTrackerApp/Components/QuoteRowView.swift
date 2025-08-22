//
//  QuoteRowView.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

import SwiftUI

struct QuoteRowView: View {
    let symbol: String
    let priceText: String
    let isUp: Bool?
    
    var body: some View {
        HStack {
            Text(symbol).font(.headline)
            Spacer()
            Text(priceText)
                .padding(6)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Image(systemName: isUp == true ? "arrow.up" : (isUp == false ? "arrow.down" : "minus"))
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    QuoteRowView(symbol: "AAPL", priceText: "$162.78", isUp: true)
}
