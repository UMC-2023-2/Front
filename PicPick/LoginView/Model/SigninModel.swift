//
//  SigninModel.swift
//  PicPick
//
//  Created by Jaeuk on 2/21/24.
//

import Foundation

struct IsDuplicateResponse: Decodable {
    let isDuplicate: Bool
    
    enum CodingKeys: String, CodingKey {
        case result
        
        case isDuplicate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
        isDuplicate = try resultContainer.decode(Bool.self, forKey: .isDuplicate)
    }
}
