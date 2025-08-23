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
    
    @State private var flash = false
    
    var body: some View {
        HStack {
            Text(symbol).font(.headline)
            Spacer()
            Text(priceText)
                .padding(6)
                .background(flash ? (isUp == true ? Color.green.opacity(0.2) :
                                        Color.red.opacity(0.2)) : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Image(systemName: isUp == true ? "arrow.up" : (isUp == false ? "arrow.down" : "minus"))
        }
        .contentShape(Rectangle())
        .onAppear { triggerFlash() }
        .onChange(of: priceText) {
            _ in triggerFlash()
        }
    }
    
    private func triggerFlash() {
        withAnimation(.easeInOut(duration: 0.25)) { flash = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 0.25)) { flash = false }
        }
    }
}

#Preview {
    QuoteRowView(symbol: "AAPL", priceText: "$162.78", isUp: true)
}
