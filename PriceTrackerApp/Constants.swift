//
//  Constants.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

import Foundation

let wsLink: String = "wss://ws.postman-echo.com/raw"

enum ConnectionStatus: Equatable {
    case disconnected, connecting, connected
    
    var title: String {
        switch self {
        case .disconnected:
            return "🔴 Disconnected"
        case .connecting:
            return "Connecting..."
        case .connected:
            return "🟢 Connected"
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

func priceFormatter(value: Double, min: Int = 2, max: Int = 2) -> String {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = min
    nf.maximumFractionDigits = max
    return nf.string(from: NSNumber(value: value)) ?? "—"
}
