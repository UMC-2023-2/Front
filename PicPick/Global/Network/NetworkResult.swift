//
//  NetworkResult.swift
//  PicPick
//
//  Created by Jaeuk on 2/17/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
