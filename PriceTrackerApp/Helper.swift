//
//  Helper.swift
//  PriceTrackerApp
//
//  Created by Christopher Nassar on 23/08/2025.
//

import Foundation

func priceFormatter(value: Double, min: Int = 2, max: Int = 2) -> String {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = min
    nf.maximumFractionDigits = max
    return nf.string(from: NSNumber(value: value)) ?? "—"
}
