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
    @Published private(set) var rows: [Row] = []
    
    private let priceFeed: PriceFeedService
    private var cancellables = Set<AnyCancellable>()
    
    init(priceFeed: PriceFeedService) {
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

