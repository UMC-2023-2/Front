//
//  PPLineButton.swift
//  PicPick
//
//  Created by Jaeuk on 1/30/24.
//

import UIKit

import PicPick_Resource

class PPLineButton: PPButton {
    override func updateConfiguration() {
        guard let configuration = configuration else {
            return
        }
        
        var updatedConfiguration = configuration
        
        var background = configuration.background
        
        background.strokeWidth = 1
        
        let backgroundColor: UIColor = .clear
        let foregroundColor: UIColor
        let font: UIFont
        let strokeColor: UIColor
        
        switch state {
        case .disabled:
            foregroundColor = R.Color.gray500
            strokeColor = R.Color.gray300
            switch buttonStyle {
            case .bottom:
                font = PPFont.titleMedium500.font
            case .content:
                font = PPFont.bodyLarge500.font
            case .textfield:
                font = PPFont.bodyLarge500.font
            }
        default:
            foregroundColor = R.Color.gray700
            strokeColor = R.Color.gray400
            switch buttonStyle {
            case .bottom:
                font = PPFont.titleMedium700.font
            case .content:
                font = PPFont.bodyLarge700.font
            case .textfield:
                font = PPFont.bodyLarge500.font
            }
        }
        
        background.strokeColor = strokeColor
        background.backgroundColor = backgroundColor
        
        updatedConfiguration.baseForegroundColor = foregroundColor
        updatedConfiguration.background = background
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
