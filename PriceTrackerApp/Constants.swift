//
//  Constants.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

let wsLink: String = "wss://ws.postman-echo.com/raw"

enum ConnectionStatus: Equatable {
    case disconnected, connecting, connected
    
    var title: String {
        switch self {
        case .disconnected:
            return "Disconnected"
        case .connecting:
            return "Connecting..."
        case .connected:
            return "Connected"
        }
    }
}

enum Symbols {
    static let defaultList: [String] = [
        "AAPL","GOOG","TSLA","AMZN","MSFT","NVDA","NFLX","META","AMD","INTC",
        "ORCL","IBM","ADBE","CRM","SHOP","UBER","LYFT","SQ","PYPL","TWTR",
        "BABA","NIO","PLTR","SPOT","SNOW"
    ]
}
