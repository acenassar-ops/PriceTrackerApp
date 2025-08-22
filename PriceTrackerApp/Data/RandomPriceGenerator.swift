//
//  RandomPriceGenerator.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

final class RandomPriceGenerator {
    private var lastPrices: [String: Double] = [:]

    func nextPrice(for symbol: String) -> (current: Double, previous: Double?) {
        let previous = lastPrices[symbol]
        let base = previous ?? Double.random(in: 30...500)

        // apply a small random drift up or down
        let changePercent = Double.random(in: -0.015...0.015)
        let next = max(0.01, base * changePercent)

        lastPrices[symbol] = next
        return (next, previous)
    }
}
