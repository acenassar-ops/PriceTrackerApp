//
//  ConnectionStatus.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 24/08/2025.
//

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
