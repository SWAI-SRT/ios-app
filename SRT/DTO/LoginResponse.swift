//
//  LoginResponse.swift
//  SRT
//
//  Created by 박성민 on 11/17/24.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let message: String
}
