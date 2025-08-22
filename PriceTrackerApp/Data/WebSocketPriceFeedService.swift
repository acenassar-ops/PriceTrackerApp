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
    
    @Published private(set) var quote: SymbolQuote = .init(symbol: "",
                                                           price: 0,
                                                           previousPrice: nil,
                                                           lastUpdate: Date())
    var quoteStatus: AnyPublisher<SymbolQuote, Never> { $quote.eraseToAnyPublisher() }
    
    private let url: URL
    private var session: URLSession!
    private var task: URLSessionWebSocketTask?
    private var timerCancellable: Timer?
    
    private let symbols: [String]
    private let generator = RandomPriceGenerator()
    private var receiveLoopActive = false
    
    init(url: URL, symbols: [String]) {
        self.url = url
        self.session = URLSession(configuration: .default)
        self.symbols = symbols
    }
    
    func start() {
        guard task == nil else { return }
        
        connection = .connecting
        let t = session.webSocketTask(with: url)
        task = t
        t.resume()
        connection = .connected
        
        startReceiving()
        startSendingTicks()
    }
    
    func stop() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        connection = .disconnected
        
        timerCancellable?.invalidate()
        timerCancellable = nil
        
        receiveLoopActive = false
    }
    
    // send a tick for every symbol every 2 seconds
    private func startSendingTicks() {
        timerCancellable = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {[weak self] timer in
            guard let self, let task = self.task else { return }
            for sym in self.symbols {
                let (current, previous) = self.generator.nextPrice(for: sym)
                let payload: [String: Any] = [
                    "symbol": sym,
                    "price": current,
                    "previous": previous ?? NSNull(),
                    "ts": Date().timeIntervalSince1970
                ]
                if let data = try? JSONSerialization.data(withJSONObject: payload, options: []),
                   let text = String(data: data, encoding: .utf8) {
                    task.send(.string(text)) { error in
                        if let error { print("send error:", error) }
                    }
                }
            }
        })
    }
    
    // receive echoed messages continuously
    private func startReceiving() {
        guard !receiveLoopActive else { return }
        receiveLoopActive = true
        receiveNext()
    }
    
    private func receiveNext() {
        task?.receive { [weak self] result in
            guard let self else { return }
            switch result {
            case .failure(let error):
                print("receive error:", error)
                self.connection = .disconnected
                self.stop()
            case .success(let message):
                self.connection = .connected
                switch message {
                case .string(let text):
                    if let data = text.data(using: .utf8),
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let symbol = json["symbol"] as? String,
                       let price = (json["price"] as? NSNumber)?.doubleValue {
                        let prev = (json["previous"] as? NSNumber)?.doubleValue
                        let quote = SymbolQuote(symbol: symbol, price: price, previousPrice: prev, lastUpdate: Date())
                        self.quote = quote
                    }
                case .data(let data):
                    // Handle binary if needed (not used here)
                    print("binary message received (ignored):", data.count)
                @unknown default:
                    break
                }
                if receiveLoopActive { self.receiveNext() }
            }
        }
    }
    
}
