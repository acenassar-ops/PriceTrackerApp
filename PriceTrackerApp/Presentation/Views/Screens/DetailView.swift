//
//  DetailView.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 23/08/2025.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(viewModel.quote?.symbol ?? "—")
                    .font(.largeTitle).bold()
                Spacer()
                if let isUp = viewModel.quote?.isUp {
                    Image(systemName: isUp ? "arrow.up" : "arrow.down")
                }
            }
            
            Text(viewModel.quote.map { priceFormatter(value: $0.price) } ?? "—")
                .font(.system(size: 42, weight: .semibold, design: .rounded))
            
            Text("This is just a placeholder for symbol details, you can pull this from an API later on")
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    let container = AppContainer()
    DetailView(viewModel: .init(symbol: "AAB",
                                priceFeed: container.priceFeed))
}
