//
//  SymbolQuote.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 24/08/2025.
//

import Foundation

struct SymbolQuote: Identifiable, Equatable {
    let id = UUID()
    let symbol: String
    let price: Double
    let previousPrice: Double?
    let lastUpdate: Date

    var isUp: Bool {
        guard let previousPrice else { return true }
        return price >= previousPrice
    }
}
