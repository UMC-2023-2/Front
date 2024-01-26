//
//  PPButton.swift
//  PicPick
//
//  Created by Jaeuk on 1/20/24.
//

import UIKit

import PicPick_Resource

class PPButton: UIButton {

    enum Style: String {
        case black = "Black"
        case white = "White"
        case line = "line"
    }

    var text: String? = nil {
        didSet {
            configuration?.title = text
        }
    }
    
    override var isEnabled: Bool {
        didSet {
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    convenience init(style: Style = .line) {
//        self.init()
//        switch style {
//        case .black:
//            setBlackStyle()
//        case .white:
//            setWhiteSytle()
//        case .line:
//            setLineStyle()
//        }
//        setConfig()
//    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLineStyle() {
        var config = UIButton.Configuration.gray()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = R.Color.gray700
        config.background.strokeWidth = 1
        config.background.strokeColor = R.Color.gray400
        configuration = config
    }
    
    private func setConfig() {
        configuration?.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        configuration?.cornerStyle = .capsule
        configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = PicPickFont.titleMedium700.font
            return outgoing
        }
        titleLabel?.textAlignment = .center
    }
}

extension PPButton.Configuration {
    public static func line() -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        
        background.strokeWidth = 1
        background.strokeColor = R.Color.gray400
        
        let foreground = R.Color.gray300
        
        config.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        config.cornerStyle = .capsule
        config.background = background
        config.baseForegroundColor = foreground
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = PicPickFont.titleMedium500.font
            return outgoing
        }
        
        return config
    }
    
    public static func white() -> UIButton.Configuration {
        var config = UIButton.Configuration.gray()
        
        let background: UIColor
        let foreground: UIColor
        
        background = R.Color.systemWhite
        foreground = R.Color.gray900
        
        config.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = PicPickFont.titleMedium700.font
            return outgoing
        }
        
        config.baseBackgroundColor = background
        config.baseForegroundColor = foreground
        
        return config
    }
    
    public static func black() -> UIButton.Configuration {
        var config = UIButton.Configuration.gray()
        
        let background: UIColor
        let foreground: UIColor
        
        background = R.Color.gray900
        foreground = R.Color.gray300
        
        config.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = PicPickFont.titleMedium700.font
            return outgoing
        }
        config.baseBackgroundColor = background
        config.baseForegroundColor = foreground
        return config
    }
}
