//
//  DetailViewModel.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 23/08/2025.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published private(set) var quote: SymbolQuote?
    
    private let priceFeed: PriceFeedService
    private var cancellables = Set<AnyCancellable>()
    private let symbol: String
    
    init(symbol: String, priceFeed: PriceFeedService) {
        self.symbol = symbol
        self.priceFeed = priceFeed
        self.quote = priceFeed.latestQuote(for: symbol)
        
        priceFeed.quoteStatus
            .filter { [symbol] in $0.symbol == symbol }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.quote = $0 }
            .store(in: &cancellables)
    }
}
