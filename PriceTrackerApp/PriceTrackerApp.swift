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
            NavigationStack {
                FeedView(viewModel: FeedViewModel(priceFeed: container.priceFeed))
            }
        }.environmentObject(container)
    }
}
