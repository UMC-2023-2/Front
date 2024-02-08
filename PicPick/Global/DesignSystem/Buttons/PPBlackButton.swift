//
//  PPBlackButton.swift
//  PicPick
//
//  Created by Jaeuk on 1/29/24.
//

import UIKit

import PicPick_Resource

class PPBlackButton: PPButton {

    override func updateConfiguration() {
        guard let configuration = configuration else {
            return
        }
        
        var updatedConfiguration = configuration
        
        let backgroundColor: UIColor
        let foregroundColor: UIColor
        let font: UIFont
        
        switch state {
        case .disabled:
            foregroundColor = R.Color.gray800
            backgroundColor = R.Color.gray700
            switch buttonStyle {
            case .bottom:
                font = PPFont.titleMedium500.font
            case .content:
                font = PPFont.bodyLarge500.font
            case .textfield:
                font = PPFont.bodyLarge500.font
            }
        default:
            foregroundColor = R.Color.gray300
            backgroundColor = R.Color.gray900
            switch buttonStyle {
            case .bottom:
                font = PPFont.titleMedium700.font
            case .content:
                font = PPFont.bodyLarge700.font
            case .textfield:
                font = PPFont.bodyLarge500.font
            }
        }
        updatedConfiguration.baseForegroundColor = foregroundColor
        updatedConfiguration.baseBackgroundColor = backgroundColor
        updatedConfiguration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = font
            return outgoing
        }
        
        self.configuration = updatedConfiguration
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
