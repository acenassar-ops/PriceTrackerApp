//
//  FeedViewModelTests.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 23/08/2025.
//

import Testing
import Combine
@testable import PriceTrackerApp

final class MockPriceFeedService: PriceFeedServiceProtocol {
    // Subjects simulate publishers
    let connectionStatusSubject = PassthroughSubject<ConnectionStatus, Never>()
    let quoteSubject = PassthroughSubject<SymbolQuote, Never>()

    // Storage for latest quotes
    private(set) var latestQuotes: [String: SymbolQuote] = [:]

    // MARK: - Protocol Conformance
    var connectionStatus: AnyPublisher<ConnectionStatus, Never> {
        connectionStatusSubject.eraseToAnyPublisher()
    }

    var quoteStatus: AnyPublisher<SymbolQuote, Never> {
        quoteSubject.eraseToAnyPublisher()
    }

    func start() { /* no-op for testing */ }
    func stop() { /* no-op for testing */ }

    func latestQuote(for symbol: String) -> SymbolQuote? {
        latestQuotes[symbol]
    }

    // MARK: - Helpers for tests
    func sendConnection(_ status: ConnectionStatus) {
        connectionStatusSubject.send(status)
    }

    func sendQuote(_ quote: SymbolQuote) {
        latestQuotes[quote.symbol] = quote
        quoteSubject.send(quote)
    }
}

struct FeedViewModelTests {
    @Test
    func connectionStatusUpdates() async throws {
        let mock = MockPriceFeedService()
        let vm = FeedViewModel(priceFeed: mock)

        mock.sendConnection(.connected)
        try await Task.sleep(for: .milliseconds(50))
        #expect(vm.connection == .connected)

        mock.sendConnection(.disconnected)
        try await Task.sleep(for: .milliseconds(50))
        #expect(vm.connection == .disconnected)
    }
    
    @Test
    func rowsUpdateWithQuotes() async throws {
        let mock = MockPriceFeedService()
        let vm = FeedViewModel(priceFeed: mock)

        // Simulate a new quote
        let quote = SymbolQuote(symbol: "AAPL", price: 120, previousPrice: 110, lastUpdate: .now)
        mock.sendQuote(quote)
        try await Task.sleep(for: .milliseconds(50))
        
        // Verify row is updated
        #expect(vm.rows.count == 1)
        #expect(vm.rows.first?.symbol == "AAPL")
        #expect(vm.rows.first?.priceText == priceFormatter(value: 120))

        // Also check mock cache (latestQuote(for:))
        let cached = mock.latestQuote(for: "AAPL")
        #expect(cached?.price == 120)
    }
}
