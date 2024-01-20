//
//  UIFont+Extension.swift
//  PicPick
//
//  Created by Jaeuk on 1/20/24.
//

import UIKit

extension UIFont {
    enum FontType: String {
        case bold = "Pretendard-Bold"
        case medium = "Pretendard-Medium"
        case semibold = "Pretendard-Semibold"
        
        var name: String {
            return self.rawValue
        }
        
        static func font(_ type: FontType, ofsize size: CGFloat) -> UIFont {
            return UIFont(name: type.rawValue, size: size)!
        }
    }
}
