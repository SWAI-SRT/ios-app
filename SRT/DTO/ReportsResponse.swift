//
//  ReportsResponse.swift
//  SRT
//
//  Created by 박성민 on 11/20/24.
//

import Foundation

struct ReportsResponse: Codable {
    let address: String
    let report: String
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case report
        case latitude
        case longitude
    }
}
