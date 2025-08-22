//
//  WebSocketPriceFeedService.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//
import Foundation
import Combine

final class WebSocketPriceFeedService: PriceFeedService {

    var connectionStatus: ConnectionStatus = .disconnected
    
    private let url: URL
    private var session: URLSession!
    private var task: URLSessionWebSocketTask?
    
    init(url: URL) {
        self.url = url
        self.session = URLSession(configuration: .default)
    }
    
    func start() {
        let t = session.webSocketTask(with: url)
        task = t
        t.resume()
    }
    
    func stop() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }
    
    
}
