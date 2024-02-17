//
//  LoginModel.swift
//  PicPick
//
//  Created by Jaeuk on 2/17/24.
//

import Foundation

struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: LoginData?
}

struct LoginData: Codable {
    let email: String
    let accessToken: String
    let refreshToken: String
}
