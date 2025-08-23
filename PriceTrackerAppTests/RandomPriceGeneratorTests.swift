//
//  PriceTrackerAppTests.swift
//  PriceTrackerAppTests
//
//  Created by Christopher Nassar on 23/08/2025.
//

import Testing
@testable import PriceTrackerApp

struct RandomPriceGeneratorTests {

    @Test
    func nextPriceProducesValue() async throws {
        let gen = RandomPriceGenerator()
        
        let (price1, previous1) = gen.nextPrice(for: "AAPL")
        #expect(price1 > 0)
        #expect(previous1 == nil, "First price should not have a previous value")
        
        let (price2, previous2) = gen.nextPrice(for: "AAPL")
        #expect(previous2 != nil, "Second call should have a previous value")
        #expect(price1 != price2, "Two consecutive prices are usually different")
    }
}
