//
//  APIConstants.swift
//  PicPick
//
//  Created by Jaeuk on 2/17/24.
//

import Foundation

struct APIConstants {
    // MARK: - BaseURL
    static let baseURL = "http://43.202.194.234:8080"
    
    // MARK: - Login & Sign Up
    static let loginURL = baseURL + "/login"
    static let isDuplicageURL = baseURL + "/member/isDuplicated"
}
