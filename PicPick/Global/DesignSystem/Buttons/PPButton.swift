//
//  PPButton.swift
//  PicPick
//
//  Created by Jaeuk on 1/30/24.
//

import UIKit

class PPButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension PPButton.Configuration {
    public static func bottom() -> UIButton.Configuration {
        var config = UIButton.Configuration.gray()
        
        config.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = PicPickFont.titleMedium700.font
            return outgoing
        }
        
        return config
    }
    
    public static func content() -> UIButton.Configuration {
        var config = UIButton.Configuration.gray()
        
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = PicPickFont.bodyLarge700.font
            return outgoing
        }
        
        return config
    }
    
    public static func textfield() -> UIButton.Configuration {
        var config = UIButton.Configuration.gray()
        
        config.contentInsets = .init(top: 13, leading: 13, bottom: 13, trailing: 13)
        config.cornerStyle = .capsule
        
        
        return config
    }
}
