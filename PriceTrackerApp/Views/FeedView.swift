//
//  ContentView.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel: FeedViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.connection.title)
                    .font(.title)
                Spacer()
                Button(viewModel.isRunning ? "Stop" : "Start") {
                    viewModel.toggleRun()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Live Prices")
    }
}

#Preview {
    let container = AppContainer()
    FeedView(viewModel: .init(priceFeed: container.priceFeed))
}
