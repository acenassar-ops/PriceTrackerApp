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
