//
//  FeedViewModel.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

import Foundation
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var isRunning: Bool = false
    @Published private(set) var connection: ConnectionStatus = .disconnected
    
    private let priceFeed: PriceFeedService
    private var cancellables = Set<AnyCancellable>()
    
    init(priceFeed: PriceFeedService) {
        self.priceFeed = priceFeed
    }
    
    func toggleRun() {
        isRunning.toggle()
        if isRunning { priceFeed.start() } else { priceFeed.stop() }
    }
}

