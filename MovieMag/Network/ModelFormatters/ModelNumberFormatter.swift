//
//  NumberFormatter.swift
//  MovieMag
//
//  Created by pc on 24.06.2022.
//

import Foundation

struct ModelNumberFormatter {
    
    let formatter = NumberFormatter()
    
    func formatCurrency(with budget: Int?) -> String {
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: budget ?? 0)) ?? "-"
    }
}
