//
//  PicPickFont.swift
//  PicPick
//
//  Created by Jaeuk on 1/20/24.
//

import UIKit

public struct FontProperty {
    let font: UIFont.FontType
    let size: CGFloat
    let kern: CGFloat
    let LineHeight: CGFloat?
}

public enum PicPickFont {
    case headlineLarge700
    case headlineMedium700
    
    case titleLarge700
    case titleMedium700
    case titleMedium500
    
    case bodyLarge700
    case bodyLarge500
    
    case captionLarge700
    case captionLarge600
    case captionLarge500
    
    public var fontProperty: FontProperty {
        switch self{
        case .headlineLarge700:
            return FontProperty(font: .bold, size: 26, kern: -2.5, LineHeight: 36)
        case .headlineMedium700:
            return FontProperty(font: .bold, size: 22, kern: -2.5, LineHeight: 26)
        case .titleLarge700:
            return FontProperty(font: .bold, size: 18, kern: -2, LineHeight: 22)
        case .titleMedium700:
            return FontProperty(font: .bold, size: 16, kern: -2, LineHeight: 20)
        case .titleMedium500:
            return FontProperty(font: .semibold, size: 16, kern: -2, LineHeight: 20)
        case .bodyLarge700:
            return FontProperty(font: .bold, size: 14, kern: -2, LineHeight: 22)
        case .bodyLarge500:
            return FontProperty(font: .medium, size: 14, kern: -2, LineHeight: 22)
        case .captionLarge700:
            return FontProperty(font: .bold, size: 12, kern: -1, LineHeight: 14)
        case .captionLarge600:
            return FontProperty(font: .semibold, size: 12, kern: -1, LineHeight: 14)
        case .captionLarge500:
            return FontProperty(font: .medium, size: 12, kern: -1, LineHeight: 14)
        }
    }
}

public extension PicPickFont {
    var font: UIFont {
        guard let font = UIFont(name: fontProperty.font.name, size: fontProperty.size) else {
            return UIFont()
        }
        
        return font
    }
}
