//
//  FeedViewModel.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

import Foundation
import Combine

final class FeedViewModel: ObservableObject {
    @Published var isRunning: Bool = false
    @Published private(set) var connection: ConnectionStatus = .disconnected
    @Published private(set) var rows: [Row] = []
    
    private let priceFeed: PriceFeedServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // local store to compute sorted rows
    private var latestQuotes: [String: SymbolQuote] = [:]
    
    init(priceFeed: PriceFeedServiceProtocol) {
        self.priceFeed = priceFeed
        bind()
    }
    
    func toggleRun() {
        isRunning.toggle()
        if isRunning { priceFeed.start() } else { priceFeed.stop() }
    }
    
    private func bind() {
        priceFeed.connectionStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] st in
                self?.connection = st
                self?.isRunning = st == .connected
            }
            .store(in: &cancellables)
        
        priceFeed.quoteStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] quote in
                guard let self else { return }
                self.latestQuotes[quote.symbol] = quote
                self.rows = self.makeRows(from: self.latestQuotes)
            }
            .store(in: &cancellables)
    }
    
    private func makeRows(from dict: [String: SymbolQuote]) -> [Row] {
        dict.values
            .sorted(by: { $0.price > $1.price })
            .map { q in Row(symbol: q.symbol, priceText: priceFormatter(value: q.price), isUp: q.isUp) }
    }
}

extension FeedViewModel {
    struct Row: Identifiable, Equatable {
        let id = UUID()
        let symbol: String
        let priceText: String
        let isUp: Bool?
    }
}

