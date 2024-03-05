//
//  LoginModel.swift
//  PicPick
//
//  Created by Jaeuk on 2/17/24.
//

import Foundation

struct LoginResponse: Decodable {
    let email: String
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case result
        
        case email
        case accessToken
        case refreshToken
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
        email = try resultContainer.decode(String.self, forKey: .email)
        accessToken = try resultContainer.decode(String.self, forKey: .accessToken)
        refreshToken = try resultContainer.decode(String.self, forKey: .refreshToken)
    }
}
