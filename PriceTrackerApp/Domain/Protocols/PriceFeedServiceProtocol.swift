//
//  Services.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 24/08/2025.
//

import Combine

protocol PriceFeedServiceProtocol: AnyObject {
    var connectionStatus: AnyPublisher<ConnectionStatus, Never> { get }
    var quoteStatus: AnyPublisher<SymbolQuote, Never> { get }
    func start()
    func stop()
    func latestQuote(for symbol: String) -> SymbolQuote?
}
