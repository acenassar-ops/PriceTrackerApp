//
//  WebSocketPriceFeedService.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//
import Foundation
import Combine

final class WebSocketPriceFeedService: PriceFeedService {

    @Published private(set) var connection: ConnectionStatus = .disconnected
    var connectionStatus: AnyPublisher<ConnectionStatus, Never> { $connection.eraseToAnyPublisher() }
    
    private let url: URL
    private var session: URLSession!
    private var task: URLSessionWebSocketTask?
    
    init(url: URL) {
        self.url = url
        self.session = URLSession(configuration: .default)
    }
    
    func start() {
        guard task == nil else { return }
        
        connection = .connecting
        let t = session.webSocketTask(with: url)
        task = t
        t.resume()
        connection = .connected
    }
    
    func stop() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        connection = .disconnected
    }
    
    
}
