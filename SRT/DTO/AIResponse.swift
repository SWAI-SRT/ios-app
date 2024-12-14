//
//  AIResponse.swift
//  SRT
//
//  Created by 박성민 on 12/13/24.
//

import Foundation

struct AIResponse: Codable {
    let detectionResults: [String]
    let report: String
    let address: String
    let latitude: Double
    let longitude: Double
}
