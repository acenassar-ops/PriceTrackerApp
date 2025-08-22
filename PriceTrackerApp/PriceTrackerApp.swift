//
//  PriceTrackerAppApp.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

import SwiftUI

@main
struct PriceTrackerApp: App {
    @StateObject private var container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            FeedView(viewModel: FeedViewModel(priceFeed: container.priceFeed))
        }.environmentObject(container)
    }
}

final class AppContainer: ObservableObject {
    // Single shared feed service so both screens observe the same stream
    let priceFeed: PriceFeedService

    init() {
        guard let url = URL(string: wsLink) else {
            fatalError( "Invalid URL" )
        }
        self.priceFeed = WebSocketPriceFeedService(url: url)
    }
}
