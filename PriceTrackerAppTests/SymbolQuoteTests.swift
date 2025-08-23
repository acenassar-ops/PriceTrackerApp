//
//  SymbolQuoteTests.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 23/08/2025.
//

import Testing
@testable import PriceTrackerApp

struct SymbolQuoteTests {
    @Test
    func deltaAndIsUp() async throws {
        let up = SymbolQuote(symbol: "AAPL", price: 100, previousPrice: 90, lastUpdate: .now)
        #expect(up.price - (up.previousPrice ?? 0) == 10)
        #expect(up.isUp == true)
        
        let down = SymbolQuote(symbol: "TSLA", price: 80, previousPrice: 90, lastUpdate: .now)
        #expect(down.price - (down.previousPrice ?? 0) == -10)
        #expect(down.isUp == false)
        
        let first = SymbolQuote(symbol: "MSFT", price: 150, previousPrice: nil, lastUpdate: .now)
        #expect(first.previousPrice == nil)
    }
}
