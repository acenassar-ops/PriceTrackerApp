//
//  FeedDomain.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//
import Foundation
import Combine

protocol PriceFeedService: AnyObject {
    var connectionStatus: AnyPublisher<ConnectionStatus, Never> { get }
    var quoteStatus: AnyPublisher<SymbolQuote, Never> { get }
    func start()
    func stop()
}

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
