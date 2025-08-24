//
//  ContentView.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 22/08/2025.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject private var container: AppContainer
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
            List(viewModel.rows) { row in
                NavigationLink(value: row.symbol) {
                    QuoteRowView(symbol: row.symbol, priceText: row.priceText, isUp: row.isUp)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Live Prices")
        .navigationDestination(for: String.self) { sym in
            DetailView(viewModel: DetailViewModel(symbol: sym, priceFeed: container.priceFeed))
        }
    }
}

#Preview {
    let container = AppContainer()
    FeedView(viewModel: .init(priceFeed: container.priceFeed))
}
