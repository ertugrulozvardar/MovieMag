//
//  ModelFormatter.swift
//  MovieMag
//
//  Created by pc on 23.06.2022.
//

import Foundation

struct ModelParameterFormatter {
    
    func formatDate() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }
    
    func formatDateByYear(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func formatDuration(with runtime: Int) -> String {
        let durationFormatter = DateComponentsFormatter()
        durationFormatter.unitsStyle = .full
        durationFormatter.allowedUnits = [.hour, .minute]
        return durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    func formatRating(with voteAvg: Double) -> String {
        let rating = Int(voteAvg)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    func formatScore(with ratingScore: String) -> String {
        guard ratingScore.count > 0 else {
            return "n/a"
        }
        return "\(ratingScore.count)/10"
    }
}
